//
//  DetailJournalView.swift
//  TravelSnap
//
//  Created by Lixing Zheng on 4/19/24.
//

import SwiftUI

struct JournalDetailView: View {
    
    // Environment objects for accessing FirebaseViewModel and Router
    @Environment(FirebaseViewModel.self) var firebaseVM
    @Environment(Router.self) var router
    
    //with this variable you can hide or show the delete button if the entry doesn't belong to the user
    @State var isUsersEntry = false
    
    var body: some View {
        

            VStack (alignment: .center){
                // Display the image associated with the journal entry
                
                //I created a variable for you in the firebaseVM that gets set from the profile or the feed screen when you click an entry.
                AsyncImage(url: URL(string: firebaseVM.selectedEntry?.photoURL ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .cornerRadius(20)
                    case .failure(_):
                        Text("No image")
                    @unknown default:
                        Text("No image")
                    }
                }
                
                HStack(){
                    Image(systemName: "mappin.circle.fill") // Marker icon
                        .font(.system(size: 50))
                        .foregroundColor(.gray) // Set color to blue
                        .padding(.trailing) // Add trailing padding to separate from the text
                    VStack{
                        Text(firebaseVM.selectedEntry?.timestamp ?? Date(), style: .date)
                            .padding(.horizontal) // Add padding to the text
                            .foregroundColor(.blue)
                        Text(firebaseVM.selectedEntry?.location ?? "")
                            .padding(.horizontal) // Add padding to the text
                            .foregroundColor(.blue)
                    }
                    
                }
                Text(firebaseVM.selectedEntry?.description ?? "")
                    .font(.caption)
                    .padding(.horizontal) // Add padding to the text
                HStack{
                    
                    Spacer()
                    
                    if isUsersEntry{
                        // Delete Entry Button
                        Button(action: {
                            Task {
                                do {
                                    try await firebaseVM.deleteEntry(id: firebaseVM.selectedEntry?.id ?? "")
                                    router.dismiss()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.black)
                                Text("Delete this entry")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        isUsersEntry = try await firebaseVM.isUsersEntry()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding(.horizontal)
            //.navigationBarItems(trailing:
            //              NavigationLink(destination: EditJournalView(journal: journal)) {
            // Image(systemName: "pencil")
            //   .font(.title)
            // .foregroundColor(.blue)
            //.padding()
            //            }
            //)
            .navigationBarTitle(firebaseVM.selectedEntry?.location ?? "")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct JournalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JournalDetailView()
            .environment(FirebaseViewModel())
            .environment(Router())
    }
}

