//
//  SettingsView.swift
//  TravelSnap
//
//  Created by Abby Damodaran.
//

import SwiftUI

struct SettingsView: View {
    
    // Environment objects for accessing AuthViewModel and Router
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    @ObservedObject var firebaseVM = FirebaseViewModel()
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
        
    var body: some View {
        VStack {
            Group {
                // display user profile
                if let profileImageURL = authViewModel.currentUser?.profilePictureURL {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top)
            .onTapGesture {
                showImagePicker.toggle()
            }
            
            List {
                Section {
                    // TODO: choose a profile picture - check func - same idea with the post
                    
                    NavigationLink(destination: PersonalInfoView()) {
                        Text("Personal information")
                        // TODO: change email - it's a button - check func
                        
                    }
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change password")
                        // TODO: reset password - it's a button - check func
                    }
                    NavigationLink(destination: ChangeUsernameView()) {
                        Text("Change username")
                        // TODO: update username - it can be a pop up with a textfield - takes a string - check func
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
            .navigationBarTitle("Settings")
        }
        .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
        .onChange(of: selectedImage) { _ in
            Task {
                if let selectedImage = selectedImage {
                    do {
                        try await firebaseVM.setProfileImage(selectedImage: selectedImage)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

struct PersonalInfoView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    var body: some View {
        Text("Personal information")
    }
}

struct ChangePasswordView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    var body: some View {
        Text("Change password")
    }
}

struct ChangeUsernameView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    var body: some View {
        Text("Change username")
    }
}


#Preview {
    SettingsView()
        .environment(AuthViewModel())
        .environment(Router())
        .environment(FirebaseViewModel())
    
}
