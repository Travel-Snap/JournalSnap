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
    
    let usersCollection = Firestore.firestore().collection("Users")
    
    // Function to sign up a new user and save the user's data in Firestore
    func signUp(username: String, email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await usersCollection.document(result.user.uid).setData(["username": username, "email": email])
    }
    
    // Function to sign in an existing user
    func signIn(email: String, Password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: Password)
    }
    
    // Function to log out the current user
    func logOut() async throws {
        try Auth.auth().signOut()
    }
    
    //Function to delete the account along with everything associated with that account.
    func deleteAccount() async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        do {
            try await usersCollection.document(currentUser.uid).delete()
            try await Auth.auth().currentUser?.delete()
        } catch {
            print(error.localizedDescription)
        }
    }
}
