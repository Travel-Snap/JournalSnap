//
//  ProfileView.swift
//  TravelSnap
//
//  Created by Lixing Zheng on 4/13/24.
//

import SwiftUI

// Profile view displaying user's journals
struct ProfileView: View {
    
    // Environment objects for accessing FirebaseViewModel and Router
    @Environment(Router.self) var router
    @Environment(FirebaseViewModel.self) var firebaseVM
    
    //an empty array to set the entries when we fetch them
    @State var entries: [Entry] = []
    
    var body: some View {
            VStack {
                HStack (alignment: .center){
                    Spacer()
                    VStack{
                        if entries.indices.contains(0) {
                            if let profilePictureURL = entries[0].profilePictureURL, let url = URL(string: profilePictureURL) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            if let username = entries[0].username {
                                Text(username)
                                    .fontWeight(.bold)
                            }
                        } else {
                            Text("Not Available")
                        }
                    }
                    
                    Text("My Journals")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    //           Settings icon
                    Button(action: {
                        router.navigate(to: .settings)
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                    })
                    
                    //TODO: because we save the username and the picture of the user, if you want to display them here before the entries, do it.
                    Spacer()  
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(entries) { entry in
                            Button(action: {
                                //we set the selected entry to the variable in the firabaseVM, so we can have access to it from the details view
                                firebaseVM.selectedEntry = entry
                                router.navigate(to: .detailsView)
                            }, label: {
                                JournalIconView(journal: entry)
                            })
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
                }
            }
            .onAppear {
                //fetching entries from firebase when the view appears
                Task {
                    do {
                        let fetchedEntries = try await firebaseVM.fetchUsersEntries()
                        entries = fetchedEntries
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
            }
        
    }
}
// Preview for ProfileView using mock data
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(entries: [Entry(photoURL: "", description: "", timestamp: Date(), location: "", username: "", profilePictureURL: "")])
            .environment(Router())
            .environment(FirebaseViewModel())
    }
}
