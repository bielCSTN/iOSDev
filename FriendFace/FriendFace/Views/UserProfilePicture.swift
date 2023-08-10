//
//  UserProfilePicture.swift
//  FriendFace
//
//  Created by Biel on 20/04/23.
//

import CoreData
import SwiftUI


struct UserProfilePicture: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    let user: CachedUser
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 220, height: 220)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                Text(user.wrappedName.components(separatedBy: " ").reduce("") {$0 + $1.first}).font(.system(size: 105))
            }
            
            if user.isActive {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.green)
                    .padding(.top, -130)
                    .padding(.leading, 140)
            }

        }
    }
}
