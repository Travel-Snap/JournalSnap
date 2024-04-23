// Post.swift
import Foundation
import FirebaseFirestoreSwift
import SwiftUI

//MARK: I do not use this post, I created a different one in the User with properties we need for now
//I kept it in case we have time to add more features to the entry.

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var userID: String
    var username: String
    var userProfilePictureURL: URL?
    var photoURL: URL?
    var caption: String
    var timestamp: Date
    var likes: [String]
    var comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id
        case userID
        case username
        case userProfilePictureURL
        case photoURL
        case caption
        case timestamp
        case likes
        case comments
    }
}

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    var userID: String
    var username: String
    var userProfilePictureURL: URL
    var text: String
    var timestamp: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userID
        case username
        case userProfilePictureURL
        case text
        case timestamp
    }
}
