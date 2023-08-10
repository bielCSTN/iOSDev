//
//  ContentView.swift
//  FriendFace
//
//  Created by Biel on 20/04/23.
//

import SwiftUI

struct Response: Codable {
    var users: [User]
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List (cachedUsers) { user in
                HStack {
                    ProfilePicture(user: user)
                    
//                    Image(systemName: "person.circle.fill")
//                        .font(.system(size: 40))
//                        .foregroundColor(user.isActive ? .green : .gray)
                        .padding(.trailing, 10)
                    VStack(alignment: .leading){
                        NavigationLink {
                            UserView(user: user)
                        } label: {
                            Text(user.wrappedName)
                        }.font(.headline)
                        Text(user.wrappedCompany)
                    }
                }
            }.task {
                if cachedUsers.isEmpty {
                    if let retrievedUsers = await getUsers() {
                        users = retrievedUsers
                    }
                }
                
                await MainActor.run {
                    for user in users {
                        let newUser = CachedUser(context: moc)
                        newUser.name = user.name
                        newUser.id = user.id
                        newUser.isActive = user.isActive
                        newUser.age = Int16(user.age)
                        newUser.about = user.about
                        newUser.email = user.email
                        newUser.address = user.address
                        newUser.company = user.company
                        newUser.formattedDate = user.formattedDate
                        
                        for friend in user.friends {
                            let newFriend = CachedFriend(context: moc)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            newFriend.user = newUser
                        }
                        
                    }
                    try? moc.save()
                }
                
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func getUsers() async -> [User]? {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedData = try decoder.decode([User].self, from: data)
                return decodedData
            } catch {
                print(error)
            }
            return nil
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
