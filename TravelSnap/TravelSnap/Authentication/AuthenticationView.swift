//
//  AuthenticationView.swift
//  TravelSnap
//
//  Created by Mina on 4/15/24.
//
import SwiftUI

struct AuthenticationView: View {
    
    // Environment objects for accessing AuthViewModel and Router
    @Environment(AuthViewModel.self) var authViewModel
    @Environment(Router.self) var router
    
    // State variables for managing user input and view state
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSigningUp: Bool = false
    @State private var isAnimating: Bool = false
    @State private var showAlert: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        ZStack {

            Image("earth")
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .offset( y: 80)
                .foregroundStyle(Gradient(colors: [.brown.opacity(0.2), .brown.opacity(0.7)]))
                .animation(.linear(duration: 30).repeatForever(autoreverses: false), value: isAnimating)
                .opacity(0.3)
                .onAppear {
                    isAnimating = true
                }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 60, height: 3)
                .offset(y: 150)
                .shadow(radius: 10)
                .opacity(0.5)
                .blur(radius: 4.0)
            
            VStack {
                
                ZStack {
                    Image("airplaneTravel")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal)
                        .shadow(radius: 8)
                    
                    Text("TravelSnap")
                        .font(.title)
                        .foregroundStyle(.teal)
                        .padding(.bottom, 40)
                    
                }
                .padding(.top, 40)
                .padding(.bottom, 40)
                
                // Text fields for user input
                VStack {
                    if isSigningUp {
                        TextField("Username", text: $username)
                    }
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
                .padding()
                
                // Button to toggle between sign up and login
                Button(action: {
                    isSigningUp.toggle()
                    
                }, label: {
                    Text(isSigningUp ? "You have an account?" : "Don't have an account?")
                        .foregroundStyle(.brown)
                        .fontWeight(.semibold)
                        
                })
                Spacer()
                
                // Button for signing up or logging in
                Button(action: {
                    if isSigningUp {
                        Task {
                            do {
                                try await authViewModel.signUp(username: username, email: email, password: password)
                                router.navigate(to: .tabBar)
                            } catch {
                                self.error = error
                                showAlert = true
                            }
                        }
                    } else {
                        Task {
                            do {
                                try await authViewModel.signIn(email: email, password: password)
                                router.navigate(to: .tabBar)
                            } catch {
                                self.error = error
                                showAlert = true
                            }
                        }
                    }
                }, label: {
                    Text(isSigningUp ? "Sign up" : "Log in")
                        .padding()
                        .foregroundStyle(.teal)
                        .frame(width: 350)
                        .background(.black.gradient)
                        .clipShape(.capsule)
                })
                .shadow(radius: 6)

            }
        }
        .alert(error?.localizedDescription ?? "Error", isPresented: $showAlert, actions: {
            Button("Try again", action: {
                showAlert = false
            })
        })
        .navigationBarBackButtonHidden()
        .background(
            Rectangle()
            .ignoresSafeArea()
            .foregroundStyle(Gradient(colors: [.brown.opacity(0.1), .brown.opacity(0.2)]))
        )
    }
}

#Preview {
    AuthenticationView()
        .environment(AuthViewModel())
        .environment(Router())
}
