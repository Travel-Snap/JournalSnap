// Post.swift
import Foundation
import FirebaseFirestoreSwift
import SwiftUI

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
