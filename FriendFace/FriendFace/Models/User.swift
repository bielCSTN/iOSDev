//
//  User.swift
//  FriendFace
//
//  Created by Biel on 20/04/23.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    var formattedDate: String {
            registered.formatted(date: .abbreviated, time: .omitted)
        }

}
