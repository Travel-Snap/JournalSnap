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
    
    @State var user: User!
    
    var body: some View {
        VStack {
            HStack (alignment: .center) {
                Spacer()
                VStack {
                    AsyncImage(url: URL(string: user?.profilePictureURL ?? "error")) { phase in
                        switch phase {
                        case .empty:
                            //when it is loading the picture
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        case .failure(_):
                            //when it is loading the picture
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        @unknown default:
                            Text("No Image")
                        }
                    }
                    .clipShape(Circle())
                    
                    Text(user?.username ?? "User")
                        .fontWeight(.bold)
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
                        .foregroundColor(.teal)
                        .padding()
                })
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(user?.entries ?? []) { entry in
                        Button(action: {
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
                    user = try await firebaseVM.fetchUsersEntries()
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
        ProfileView()
            .environment(Router())
            .environment(FirebaseViewModel())
    }
}
