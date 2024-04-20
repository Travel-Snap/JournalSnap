//  Dummy data for home feed


import Foundation
import SwiftUI

struct DummyData {
    static let dummyImageURL = "https://images.unsplash.com/photo-1501555088652-021faa106b9b?q=80&w=2373&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG900by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    static let dummyImage = UIImage(named: "dummyImage")!
    
        static let dummyPosts: [Post] = [
            Post(userID: "user1", username: "User One", userProfilePictureURL: URL(string: "https://dummy.com/profile1.jpg")!, photoURL: URL(string: "https://dummy.com/photo1.jpg")!, caption: "Went on a solo trip to Iceland", timestamp: Date(), likes: ["user2", "user3"], comments: []),
            Post(userID: "user2", username: "User Two", userProfilePictureURL: URL(string: "https://dummy.com/profile2.jpg")!, photoURL: URL(string: "https://dummy.com/photo2.jpg")!, caption: "Visited Japan!", timestamp: Date().addingTimeInterval(-10000), likes: ["user1"], comments: []),
            Post(userID: "user3", username: "User Three", userProfilePictureURL: URL(string: "https://dummy.com/profile3.jpg")!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user4", username: "User One", userProfilePictureURL: URL(string: "https://dummy.com/profile1.jpg")!, photoURL: URL(string: "https://dummy.com/photo1.jpg")!, caption: "Went on a solo trip to Iceland", timestamp: Date(), likes: ["user2", "user3"], comments: []),
            Post(userID: "user5", username: "User Two", userProfilePictureURL: URL(string: "https://dummy.com/profile2.jpg")!, photoURL: URL(string: "https://dummy.com/photo2.jpg")!, caption: "Visited Japan!", timestamp: Date().addingTimeInterval(-10000), likes: ["user1"], comments: []),
            Post(userID: "user6", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user7", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user8", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user9", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user10", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user11", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user12", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user13", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user14", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: []),
            Post(userID: "user15", username: "User Three", userProfilePictureURL: URL(string:dummyImageURL)!, photoURL: URL(string: "https://dummy.com/photo3.jpg")!, caption: "I love the cherry blossom season", timestamp: Date().addingTimeInterval(-20000), likes: [], comments: [])
        ]
}
