//
//  WelcomeView.swift
//  TravelSnap
//
//  Created by Mina on 4/15/24.
//

import SwiftUI

struct WelcomeView: View {
    
    // Environment objects for accessing AuthViewModel and Router
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    
    // State variables for managing font size animation
    @State private var maxFontSize: CGFloat = 70
    @State private var fontSize: CGFloat = 5
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.brown.opacity(0.1))
            
            // Texts forming "TravelSnap" with animation
            HStack {
                Text("T")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("r")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)

                Text("a")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("v")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("e")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("l")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("S")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("n")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("a")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("p")
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
            }
            .onAppear {
                fontSize = 5
                
                // Timer to animate the font size incrementally
                Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                    withAnimation {
                        fontSize += 1
                        // When maximum font size is reached, stop the timer and navigate
                        if fontSize == maxFontSize {
                            
                            timer.invalidate()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if authViewModel.user != nil {
                                    //Feed screen
                                    router.navigate(to: .tabBar)
                                } else {
                                    router.navigate(to: .authentication)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environment(AuthViewModel())
        .environment(Router())
}
