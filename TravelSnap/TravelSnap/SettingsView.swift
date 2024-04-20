//
//  SettingsView.swift
//  TravelSnap
//
//  Created by Abby Damodaran.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
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
                        // TODO: Log out action implementation
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
}

struct PersonalInfoView: View {
    var body: some View {
        Text("Personal information")
    }
}

struct ChangePasswordView: View {
    var body: some View {
        Text("Change password")
    }
}

struct ChangeUsernameView: View {
    var body: some View {
        Text("Change username")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


#Preview {
    SettingsView()
}
