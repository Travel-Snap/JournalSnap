//
//  User.swift
//  TravelSnap
//
//  Created by Mina on 4/21/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable {

    var username: String
    var email: String
    var profilePictureURL: String?
    var entries: [Entry]?
}

struct Entry: Codable, Identifiable {
    @DocumentID var id: String?
    var photoURL: String
    var description: String
    var timestamp: Date
    var location: String
    var likes: Int?
    var comments: [String]?
    var userID: String
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoURL
        case description
        case timestamp
        case location
        case likes
        case comments
        case userID
    }
}
