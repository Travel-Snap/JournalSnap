//
//  TravelSnapApp.swift
//  TravelSnap
//
//  Created by Abby Damodaran on 4/13/24.
//

import SwiftUI
import Firebase

@main
struct TravelSnapApp: App {
    
    @State var authViewModel: AuthViewModel
    @State var router = Router()
    @State var firebaseViewModel: FirebaseViewModel
    
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Initialize authentication view model
        authViewModel = AuthViewModel()
        firebaseViewModel = FirebaseViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            // Navigation stack to manage views
            NavigationStack(path: $router.navigationPath) {
                WelcomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .authentication:
                            AuthenticationView()
                        case .tabBar:
                            TabBarView()
                        case .detailsView:
                            JournalDetailView()
                        case .settings:
                            SettingsView()
                   
                        }
                    }
            }
            .environment(authViewModel) // Providing authentication view model to the environment
            .environment(router) // Providing Router to the environment
            .environment(firebaseViewModel)
        }
    }
}
