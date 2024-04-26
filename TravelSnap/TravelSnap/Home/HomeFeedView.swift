//  HomeFeedView.swift

import SwiftUI

struct HomeFeedView: View {
    @StateObject private var viewModel = HomeFeedViewModel()
    
    @Environment(FirebaseViewModel.self) var firebaseVM
    @Environment(Router.self) var router
    
    @State var entries: [Entry] = []
    
//    var body: some View {
//
//        List(entries) { entry in
//            
//            //TODO: put the postView into a button, so if pressed it will go to the details view
//            //because we use the router, you can't pass the entry direclty from here to the details view, set the entry to the selectedEntry I created in the firebaseVM that gets set into the detailsView.
//            
//                PostView(entry: entry)
//
//                }
//                .navigationBarTitle("TravelSnap")
//                .navigationBarTitleDisplayMode(.inline)
//                .onAppear {
//                    // use once firebase fetch is implemented
//                    Task {
//                        do {
//                            entries = try await firebaseVM.fetchEntries()
//                            
//                        }
//                    }
//                }
//        }
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(400)), count: 1)) {
                        ForEach(entries) { entry in
//                            NavigationLink(destination: PostView(entry: entry)) {
//                                PostView(entry: entry)
//                            }
                            
                            Button(action: {
                                                // Set the selectedEntry in the FirebaseViewModel
                                                firebaseVM.selectedEntry = entry
                                                // Navigate to the DetailJournalView
                                router.navigate(to: .detailsView)
                                            }) {
                                                PostView(entry: entry)
                                            }
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("TravelSnap", displayMode: .inline)
                .onAppear {
                    Task {
                        do {
                            entries = try await firebaseVM.fetchEntries()
                        } catch {
                            print("Error during fetchEntries: \(error)")
                        }
                    }
                }
            }
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    HomeFeedView( entries: [Entry(photoURL: "", description: "", timestamp: Date(), location: "", username: "", profilePictureURL: "")])
        .environment(FirebaseViewModel())
        .environment(Router())
}
