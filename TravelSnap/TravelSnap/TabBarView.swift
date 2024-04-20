//
//  TabBarView.swift
//  TravelSnap
//
//  Created by Mina on 4/19/24.
//

import SwiftUI


struct TabBarView: View {
    
    @Environment(Router.self) var router
    
    var body: some View {
        TabView {
            HomeFeedView()
                .tabItem {
                    Label("", systemImage: "house")
                }
            
            // create screen
            
            ProfileView(user: mockUsers.first!)
                .tabItem {
                    Label("", systemImage: "person")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
        .environment(Router())
}
