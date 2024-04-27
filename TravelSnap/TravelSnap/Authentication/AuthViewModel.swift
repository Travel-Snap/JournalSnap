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
    
  private let usersCollection = Firestore.firestore().collection("Users")
    
    //custom error cases for authentication-related errors.
    enum AuthError: String, LocalizedError {
        case invalidUsername = "Enter a username"
        case invalidEmail = "Enter a valid email"
        case invalidPassword = "The password has to be at least 6 characters"
        case invalidCredentials = "The email or password is wrong"
        
        var errorDescription: String? {
            return self.rawValue
        }
    }
    
    // function that checks if the email is valid
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    
    // Function to sign up a new user and save the user's data in Firestore
    func signUp(username: String, email: String, password: String) async throws {
        guard !username.isEmpty else {throw AuthError.invalidUsername }
        guard isValidEmail(email) else {throw AuthError.invalidEmail}
        guard password.count > 5 else {throw AuthError.invalidPassword}
        
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await usersCollection.document(result.user.uid).setData(["username": username, "email": email])
    }
    
    // Function to sign in an existing user
    func signIn(email: String, password: String) async throws {
        guard isValidEmail(email) else {throw AuthError.invalidEmail}
        guard password.count > 5 else {throw AuthError.invalidPassword}
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            
        } catch {
            throw AuthError.invalidCredentials
        }
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
