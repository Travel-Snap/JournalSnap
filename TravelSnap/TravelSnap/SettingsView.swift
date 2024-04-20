//
//  SettingsView.swift
//  TravelSnap
//
//  Created by Abby Damodaran.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
        
    var body: some View {

            List {
                Section {
                    NavigationLink(destination: PersonalInfoView()) {
                        Text("Personal information")
                        // TODO: Personal information screen
                    }
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change password")
                        // TODO: Change password screen
                    }
                    NavigationLink(destination: ChangeUsernameView()) {
                        Text("Change username")
                        // TODO: Change username screen
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
                        // TODO: Delete account action implementation
                    }) {
                        Text("Delete the account")
                            .foregroundColor(.red) // Styled as red for caution
                    }
                }
            }
            .navigationBarTitle("Settings")
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
    
}
