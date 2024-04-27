//
//  TabBarView.swift
//  TravelSnap
//
//  Created by Mina on 4/19/24.
//

import SwiftUI


struct TabBarView: View {
    
    @Environment(Router.self) var router
    @Environment(FirebaseViewModel.self) var firebaseVM
    
    
    var body: some View {
        TabView {
            HomeFeedView()
                .tabItem {
                    Label("", systemImage: "house")
                }
            CreatePostView()
                .tabItem {
                    Label("", systemImage: "plus.app")
                }
            
            ProfileView()
                .tabItem {
                    Label("", systemImage: "person")
                }
        }
        .tint(.teal)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
        .environment(Router())
        .environment(FirebaseViewModel())
}
