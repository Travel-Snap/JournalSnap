//
//  FirebaseViewModel.swift
//  TravelSnap
//
//  Created by Mina on 4/21/24.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

@Observable
class FirebaseViewModel {
    
    //this variable is used to pass the entry from the profileView or HomeFeedView to the detailJournalView.
    var selectedEntry: Entry!
    var entryUser: User!
    
    //references to the firebase collections
    let usersCollection = Firestore.firestore().collection("Users")
    let entriesCollection = Firestore.firestore().collection("Entries")
    let entryImagesReference = Storage.storage().reference(withPath: "entries")
    let profileImagesReference = Storage.storage().reference(withPath: "profilePictures")
    
    
    //this function save an entry for the createPostView
    func saveEntry(description: String, location: String, selectedImage: UIImage) async throws {
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        let document = entriesCollection.document()
        
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            
            let imageReference = entryImagesReference.child(document.documentID)
            let _ = try await imageReference.putDataAsync(imageData)
            let photoURL = try await imageReference.downloadURL().absoluteString
            
            let entry = Entry(photoURL: photoURL, description: description, timestamp: Date(), location: location, userID: currentUserID)
            try entriesCollection.document(document.documentID).setData(from: entry)
        }
        try await usersCollection.document(currentUserID).collection("entries").document(document.documentID).setData(["timestamp" : Date()])
    }
    
    //this function fetches all the entries from the firebase for the HomeFeedView
    func fetchEntries() async throws -> [Entry] {
        var entries: [Entry] = []
        
        let snapshot = try await entriesCollection.getDocuments()
        
        await withTaskGroup(of: Entry?.self) { group in
            snapshot.documents.forEach { document in
                group.addTask {
                    do {
                        var entry = try document.data(as: Entry.self)
                        let userDocument = try await self.usersCollection.document(entry.userID ?? "error").getDocument()
                        
                        let user = try userDocument.data(as: User.self)
                        entry.user = user
                        return entry
                        
                    } catch {
                        return nil
                    }
                }
            }
            for await entry in group {
                if let entry {
                    entries.append(entry)
                }
            }
        }
        return entries.sorted {$0.timestamp > $1.timestamp}
    }
    
    
    
    //this function fetches the current user's entries from the firebase for the profileView
    func fetchUsersEntries() async throws -> User? {
        guard let currentUser = Auth.auth().currentUser else {return (nil)}
        
        var entries: [Entry] = []
        let userSnapshot = try await usersCollection.document(currentUser.uid).getDocument()
        var user = try userSnapshot.data(as: User.self)
        let snapshot = try await usersCollection.document(currentUser.uid).collection("entries").getDocuments()
        for doc in snapshot.documents {
            let document = try await entriesCollection.document(doc.documentID).getDocument()
            let entry = try document.data(as: Entry.self)
            entries.append(entry)
        }
        user.entries = entries
        return user
    }
    
    //this function is checking if the entry belongs to the current user - for detailJournalView
    func isUsersEntry() async throws -> Bool {
        guard let currentUser = Auth.auth().currentUser else {return false}
        
        var isUsersEntry = false
        
        let snapshot = try await usersCollection.document(currentUser.uid).collection("entries").getDocuments()
        snapshot.documents.forEach { doc in
            if doc.documentID == selectedEntry.id {
                isUsersEntry = true
            }
        }
        return isUsersEntry
    }
    
    func deleteEntry(id: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        try await entryImagesReference.child(id).delete()
        try await entriesCollection.document(id).delete()
        try await usersCollection.document(currentUser.uid).collection("entries").document(id).delete()
    }
    
    // settingsView functions
    
    func setProfileImage(selectedImage: UIImage) async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        
        if let imageData = selectedImage.jpegData(compressionQuality: 0.5) {
            let imageReference = profileImagesReference.child(currentUser.uid)
            let _ = try await imageReference.putDataAsync(imageData)
            let photoURL = try await imageReference.downloadURL().absoluteString
            try await usersCollection.document(currentUser.uid).updateData(["profilePictureURL" : photoURL])
            
            let snapshot = try await usersCollection.document(currentUser.uid).collection("entries").getDocuments()
            snapshot.documents.forEach { entry in
                Task {
                    try await entriesCollection.document(entry.documentID).updateData(["profilePictureURL" : photoURL])
                }
            }
        }
        
    }
    
    func updateUsername(username: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        try await usersCollection.document(currentUser.uid).updateData(["username" : username])
    }
    
    // it is not going to working 100% corrent. we need to discuss this
    func updateEmail(email: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {return}
        
        try await currentUser.sendEmailVerification(beforeUpdatingEmail: email)
        
    }
    
    func resetPassword() async throws {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {return}
        try await Auth.auth().sendPasswordReset(withEmail: currentUserEmail)
    }
    
    func fetchUserProfilePictureURL() async throws -> String? {
        guard let currentUser = Auth.auth().currentUser else {return nil}
        
        let document = try await usersCollection.document(currentUser.uid).getDocument()
        let user = try document.data(as: User.self)
        
        return user.profilePictureURL
        
    }
    
}
