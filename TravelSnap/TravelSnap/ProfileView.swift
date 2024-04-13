//
//  ProfileView.swift
//  TravelSnap
//
//  Created by Lixing Zheng on 4/13/24.
//

import SwiftUI

// Mock data for a user
struct User {
    let name: String
    let journals: [JournalEntry]
}

// Mock journals
struct JournalEntry {
    let title: String
    let image: String // Name of the image in the assets catalog
}

// Mock data for users
let mockUsers: [User] = [
    User(name: "John John", journals: [
        JournalEntry(title: "Morning Walk", image: "MorningWalkMockImage"),
        JournalEntry(title: "Lunch with Friends", image: "LunchFriendsMockImage"),
        JournalEntry(title: "Sunset Beach", image: "SunSetMockImage")
    ]),
    User(name: "Jane Smith", journals: [
        JournalEntry(title: "Hiking Adventure", image: "hiking_adventure"),
        JournalEntry(title: "Coffee Date", image: "coffee_date"),
        JournalEntry(title: "City Lights", image: "city_lights")
    ])
]

// Profile view displaying user's journals
struct ProfileView: View {
    let user: User // Pass user as a parameter
    
    var body: some View {
        VStack {
                    Text("My Journals")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                            ForEach(user.journals, id: \.title) { journal in
                                JournalIconView(journal: journal)
            
                            }
                        }
                        .padding([.horizontal, .bottom], 20)
                    }
                }
            }
}

// Preview for ProfileView using mock data
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: mockUsers[0]) // Pass a user from mockUsers
    }
}
