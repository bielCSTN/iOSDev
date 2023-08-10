//
//  Hino.swift
//  VPT
//
//  Created by Biel on 08/08/23.
//

import Foundation

struct Hino: Codable, Identifiable {
    let id: String
    let hino: Int
    let letra: String
    
    static let todosHinos: [Hino] = Bundle.main.decode("hinos.json")
    static let example = todosHinos[0]
}
