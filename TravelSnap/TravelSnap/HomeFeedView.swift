//  HomeFeedView.swift

import SwiftUI

struct HomeFeedView: View {
    @StateObject private var viewModel = HomeFeedViewModel()
    
    var body: some View {

                List(viewModel.posts) { post in
                    PostView(post: post)
                }
                .navigationBarTitle("TravelSnap")
                .navigationBarTitleDisplayMode(.inline)

        }
        //        .onAppear {
        //            // use once firebase fetch is implemented
        //            viewModel.fetchPosts()
        //        }
}

//struct HomeFeedView: View {
//    @StateObject private var viewModel = HomeFeedViewModel()
//    
//    var body: some View {
//        NavigationView {
//            UIHostingController(rootView: HomeFeedViewController(viewModel: viewModel))
////                .onAppear {
////                    viewModel.fetchPosts()
////                }
//        }
//    }
//}

#Preview {
    HomeFeedView()
}
