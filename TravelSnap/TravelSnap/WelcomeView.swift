//
//  WelcomeView.swift
//  TravelSnap
//
//  Created by Mina on 4/15/24.
//

import SwiftUI
import FirebaseAuth

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
                .foregroundStyle(Gradient(colors: [.brown.opacity(0.1), .brown.opacity(0.2)]))
            // Texts forming "TravelSnap" with animation
            HStack {
                Text("T")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("r")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)

                Text("a")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("v")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("e")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("l")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("S")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("n")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("a")
                    .foregroundStyle(.teal)
                    .font(.system(size: fontSize))
                    .offset(
                        x: fontSize == maxFontSize ? CGFloat(Int.random(in: -300...300)) : 0,
                        y: fontSize == maxFontSize ? CGFloat(Int.random(in: -400...400)) : 0
                    )
                    .opacity(fontSize == maxFontSize ? 0 : 1)
                
                Text("p")
                    .foregroundStyle(.teal)
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
                                if Auth.auth().currentUser != nil {
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
