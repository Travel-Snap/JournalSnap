//
//  TestView.swift
//  TravelSnap
//
//  Created by Mina on 4/18/24.
//

import SwiftUI


struct TestView: View {
    
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    
    var body: some View {
        ZStack {
            Button(action: {
                
                Task {
                    try await authViewModel.logOut()
                    router.popToRoot()
                    
                    
                }
            }, label: {
                Text("Log Out")
            })
        }
        
    }
}

#Preview {
    TestView()
        .environment(AuthViewModel())
}
