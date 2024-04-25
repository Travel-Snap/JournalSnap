//
//  User.swift
//  TravelSnap
//
//  Created by Mina on 4/21/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable {

    let username: String
    let email: String
    let profilePictureURL: String?
    let entries: [Entry]?
}

struct Entry: Codable, Identifiable {
    @DocumentID var id: String?
    var photoURL: String
    var description: String
    var timestamp: Date
    var location: String
    var likes: Int?
    var comments: [String]?
    let username: String?
    let profilePictureURL: String?
}
