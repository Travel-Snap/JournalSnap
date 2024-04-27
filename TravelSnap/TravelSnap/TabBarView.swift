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
    
    init() {
//        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().unselectedItemTintColor = UIColor.white
//        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    
    var body: some View {
        TabView {
            
            HomeFeedView()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }
            
            CreatePostView()
                .tabItem {
                    Label("Add", systemImage: "plus.app")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
        .environment(Router())
        .environment(FirebaseViewModel())
}
