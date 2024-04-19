//  HomeFeedViewModel.swift

import Foundation

// HomeFeedViewModel.swift

import Combine
import SwiftUI

class HomeFeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    init() {
        loadDummyData()
    }

    func loadDummyData() {
        posts = DummyData.dummyPosts
    }

    // need to change to fetch data from Firebase later
}

