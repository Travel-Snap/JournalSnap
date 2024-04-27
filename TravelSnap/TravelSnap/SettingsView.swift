//
//  SettingsView.swift
//  TravelSnap
//
//  Created by Abby Damodaran.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct SettingsView: View {
    
    // Environment objects for accessing AuthViewModel and Router
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    @Environment(FirebaseViewModel.self) var firebaseVM
    
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    @State private var pictureURL: String?
    
    
    @State var showAlertForPassword: Bool = false
    @State var ShowPopUp: Bool = false
    @State var newUsername: String = ""
    @State var newEmail: String = ""
    @State var ShowPopUpForEmail: Bool = false
    
    
    var body: some View {
        VStack {
            Group {
                // display user profile
                if let profileImageURL = pictureURL {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top)
            .overlay(alignment: .bottomTrailing){
                PhotosPicker(
                    selection: $selectedItem, matching: .images) {
                        Image(systemName: "camera")
                            .foregroundColor(.black)
                            .padding(12)
                            .background(Circle().foregroundStyle(.teal))
                    }
            }
            
            List {
                Section {
                    // TODO: choose a profile picture - check func - same idea with the post
                    
                    Button(action: {
                        ShowPopUp = true
                    }, label: {
                        Text("Change Username")
                    })
                    
                    Button(action: {
                        ShowPopUpForEmail = true
                        
                    }) {
                        Text("Update Email")
                    }
                    
                    Button(action: {
                        showAlertForPassword = true
                        
                    }) {
                        Text("Reset Password")
                    }
                    
                    Button(action: {
                        Task {
                            do {
                                try await authViewModel.logOut()
                                router.popToRoot()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }) {
                        Text("Log out")
                    }
                    
                    Button(action: {
                        Task {
                            try await authViewModel.deleteAccount()
                            router.popToRoot()
                        }
                    }) {
                        Text("Delete the account")
                            .foregroundColor(.red) // Styled as red for caution
                    }
                }
            }
            .alert("Enter your new email", isPresented: $ShowPopUpForEmail, actions: {
                TextField("", text: $newEmail)
                Button("Save") {
                    Task {
                        do {
                            try await firebaseVM.updateEmail(email: newEmail)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                Button("Cancel", action: {})
            }, message: {
                Text("An email will be sent to your previous email for verification.")
            })
            
            .alert("Enter your new username", isPresented: $ShowPopUp, actions: {
                TextField("", text: $newUsername)
                Button("Save") {
                    Task {
                        do {
                            try await firebaseVM.updateUsername(username: newUsername)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                Button("Cancel", action: {})
            })
            .alert("An email will be sent to you with instructions on how to reset your password.", isPresented: $showAlertForPassword, actions: {
                Button("Send") {
                    Task {
                        do {
                            try await firebaseVM.resetPassword()
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                Button("cancel") {}
            })
            .navigationBarTitle("Settings")
        }
        .onAppear {
            Task {
                do {
                    pictureURL = try await firebaseVM.fetchUserProfilePictureURL()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .onChange(of: selectedItem) { _, _ in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImage = image
                    try await firebaseVM.setProfileImage(selectedImage: image)
                    pictureURL = try await firebaseVM.fetchUserProfilePictureURL()

                } else {
                    print("load failed")
                }
            }
        }
    }
}



#Preview {
    SettingsView()
        .environment(AuthViewModel())
        .environment(Router())
        .environment(FirebaseViewModel())
    
}
