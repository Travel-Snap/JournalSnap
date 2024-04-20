//
//  AuthViewModel.swift
//  TravelSnap
//
//  Created by Mina on 4/15/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// Observable class responsible for managing authentication related operations
@Observable
class AuthViewModel {
    
    // Current user object retrieved from FirebaseAuth
    let user = Auth.auth().currentUser
    
    // Function to sign up a new user and save the user's data in Firestore
    func signUp(username: String, email: String, password: String) async throws {
        let userReference = Firestore.firestore().collection("Users")
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await userReference.document(result.user.uid).setData(["username": username, "email": email])
    }
    
    // Function to sign in an existing user
    func signIn(email: String, Password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: Password)
    }
    
    // Function to log out the current user
    func logOut() async throws {
        try Auth.auth().signOut()
    }
}
