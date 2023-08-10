//
//  UserView.swift
//  FriendFace
//
//  Created by Biel on 20/04/23.
//

import CoreData
import SwiftUI

struct UserView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    let user: CachedUser
    
    var body: some View {
        ScrollView {
            
            UserProfilePicture(user: user)
                .padding(.top, 25)
            
            VStack(alignment: .leading) {
                Text("About")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                Text(user.wrappedAbout)
                
                
                Spacer(minLength: 50)
                
                Text("Friends")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach (user.friendsArray) { friend in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.gray)
                                    .opacity(0.40)
                                    .frame(width: 130, height: 130)
                                
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.gray)
                                            .opacity(0.7)
                                        Text(friend.wrappedName.components(separatedBy: " ").reduce("") {$0 + $1.first}).font(.title3.bold())
                                    }
                                    
                                    Text(friend.wrappedName)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
                
//                Spacer(minLength: 25)
                
//                Text("Tags")
//                    .font(.title.bold())
//                    .padding(.bottom, 5)
                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(user.tags, id: \.self) { tag in
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 5)
//                                    .foregroundColor(.red)
//                                    .opacity(0.20)
//                                    .frame(width: 130, height: 50)
//
//                                Text(tag)
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                }
                
            }.padding()
                .padding(.top, -35)
            
            Spacer(minLength: 35)
            
            VStack(alignment: .center) {
                Text(user.wrappedAddress)
                    .font(.footnote)
                Spacer(minLength: 5)
                Text(user.wrappedEmail)
                    .font(.footnote)
            }
            .padding()
            .padding(.top, -20)
            .navigationTitle("\(user.wrappedName) - from \(user.wrappedCompany)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
