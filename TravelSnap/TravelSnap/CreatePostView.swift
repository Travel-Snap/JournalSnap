//
//  CreatePostView.swift
//  TravelSnap
//
//  Created by Abby Damodaran.
//

import SwiftUI
import PhotosUI

struct CreatePostView: View {
    
    // Environment objects for accessing FirebaseViewModel
    @Environment(FirebaseViewModel.self) var firebaseVM
    
    @State private var journalEntry: String = ""
    @State private var location: String = ""
    @State private var selectedImage: UIImage!
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // TODO: Handle exit action

                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    // TODO: Handle save action
                    //take the description, location and selectedImage and save the entry to the firebase
                    //check the func in the firebaseVM
                    
                    // MARK: You can uncomment the code when you are ready to post
//                    Task {
//                        do {
//                            try await firebaseVM.saveEntry(description: journalEntry, location: location, selectedImage: selectedImage)
//                        } catch {
//                            print(error.localizedDescription)
//                        }
//                    }
                    
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
                .padding(.trailing)
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Write a journal entry")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                TextField("", text: $journalEntry)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity) // Allow the TextField to expand vertically
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                HStack {
                    Spacer()
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // Set smaller size
                            .foregroundColor(.gray) // Set gray color
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                // TODO: Handle photo picker action
                            }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // Set smaller size
                            .foregroundColor(.gray) // Set gray color
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                // TODO: Handle photo picker action
                            }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                // ////// PhotosPicker
                Spacer()
                
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    .controlSize(.large)
                .foregroundColor(.gray)
                .frame(alignment: .center)
                
                
                Spacer()
                // //////
                
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.gray)
                    TextField("Location", text: $location)
                        .padding(.horizontal)
                        .frame(maxHeight: 50) // Make the location text box bigger
                }
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
    }
    
    
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .environment(FirebaseViewModel())
    }
}
