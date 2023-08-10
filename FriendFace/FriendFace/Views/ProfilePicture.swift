//
//  ProfilePicture.swift
//  FriendFace
//
//  Created by Biel on 20/04/23.
//

import CoreData
import SwiftUI



extension String {
    public var first: String {
        return String(self[startIndex])
    }
}

struct ProfilePicture: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    let user: CachedUser
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(user.isActive ? .green : .gray)
                .opacity(0.7)
            Text(user.wrappedName.components(separatedBy: " ").reduce("") {$0 + $1.first}).font(.title3.bold())
        }
    }
}
