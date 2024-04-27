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

    @State var isUsersEntry = false
    
    var body: some View {
        
        
        VStack {
            // Display the image associated with the journal entry
            
            AsyncImage(url: URL(string: firebaseVM.selectedEntry?.photoURL ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
//                    Image(systemName: "person")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 300, height: 300)
                        .cornerRadius(20)
                case .failure(_):
                    Text("No image")
                @unknown default:
                    Text("No image")
                }
            }
            .padding(.top)
            .padding(.horizontal)
            HStack{
                Image(systemName: "mappin.circle.fill") // Marker icon
                    .font(.system(size: 25))
                    .foregroundColor(.red) // Set color to blue
                
                HStack{
                    Text(firebaseVM.selectedEntry?.location ?? "New York, NY")
                        .foregroundColor(.black)
                    Spacer()
                    Text(firebaseVM.selectedEntry?.timestamp ?? Date(), style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            .padding(.horizontal)
            
            HStack {
                Text("Description:")
                    .foregroundStyle(.black.opacity(0.8))
                    .padding()
                    .underline(true)
                Spacer()
                
            }
            ScrollView {
                Text(firebaseVM.selectedEntry?.description ?? "")
                    .font(.system(size: 14))
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
            }
            
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
                    }
                    .frame(width: 300)
                    .padding()
                    .background(.teal)
                    .clipShape(Capsule())
                    
                }
                .padding(.horizontal)
                
                
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
        .navigationBarTitle(firebaseVM.selectedEntry?.user?.username ?? "")
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

