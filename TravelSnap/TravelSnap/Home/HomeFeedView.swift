//  HomeFeedView.swift

import SwiftUI

struct HomeFeedView: View {
    @StateObject private var viewModel = HomeFeedViewModel()
    
    @Environment(FirebaseViewModel.self) var firebaseVM
    @Environment(Router.self) var router
    
    @State var entries: [Entry] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(400)), count: 1)) {
                    ForEach(entries) { entry in
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


#Preview {
    HomeFeedView( entries: [Entry(photoURL: "", description: "", timestamp: Date(), location: "", userID: "CwBtmdDx3kQ2N3oQ72YfYcFoLFD3")])
        .environment(FirebaseViewModel())
        .environment(Router())
}
