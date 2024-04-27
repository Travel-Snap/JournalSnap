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
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        Task {
                            do {
                                try await firebaseVM.saveEntry(description: journalEntry, location: location, selectedImage: selectedImage)
                                journalEntry = ""
                                location = ""
                                selectedImage = nil
                                selectedItem = nil
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }) {
                        Text("Save")
                            .foregroundColor(.teal)
                            .fontWeight(.bold)
                    }
                    .padding(.trailing)
                }
                .padding()
                
                // temporarily placing image here
                ZStack {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 370, maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding()
                    } else {
                        Text("No image selected")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Write a journal entry")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    TextEditor(text: $journalEntry)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity) // Allow the TextField to expand vertically
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    
                    HStack() {
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            HStack{
                                Image(systemName: "camera")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .foregroundStyle(.black)
                                Text("Pick a picture")
                                    .foregroundStyle(.black)
                            }
                            .padding(.horizontal)
                        }
                        .controlSize(.large)
                        .foregroundColor(.gray)
                    }
                    .onDisappear(perform: {
                        journalEntry = ""
                        location = ""
                        selectedImage = nil
                        selectedItem = nil
                    })
                    .onChange(of: selectedItem) {
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    selectedImage = image
                                } else {
                                    print("image load failed")
                                }
                            }
                        }
                    }
                    Spacer()
                    
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
            .navigationBarTitle("Add Entry", displayMode: .inline)
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .environment(FirebaseViewModel())
    }
}
