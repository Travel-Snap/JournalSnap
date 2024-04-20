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
    let caption: String
    let date: String
    let location: String
    
}

// Mock data for users
let mockUsers: [User] = [
    User(name: "John John", journals: [
        JournalEntry(title: "Place one", image: "MorningWalkMockImage", caption: "This is descriptopn", date:"some date", location:"some location"),
        JournalEntry(title: "Place two", image: "LunchFriendsMockImage", caption: "This is descriptopn", date:"some date", location:"some location"),
        JournalEntry(title: "Place three", image: "SunSetMockImage", caption: "This is descriptopn", date:"some date", location:"some location")
    ]),
    User(name: "Jane Smith", journals: [
        JournalEntry(title: "Hiking Adventure", image: "hiking_adventure", caption: "This is descriptopn", date:"some date", location:"some location"),
        JournalEntry(title: "Coffee Date", image: "coffee_date", caption: "This is descriptopn", date:"some date", location:"some location"),
        JournalEntry(title: "City Lights", image: "city_lights", caption: "This is descriptopn", date:"some date", location:"some location")
    ])
]

// Profile view displaying user's journals
struct ProfileView: View {
    
    @Environment(Router.self) var router
    
    let user: User // Pass user as a parameter
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Journals")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    //           Settings icon
                    Button(action: {
                        router.navigate(to: .settings)
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                    })
                    //                    NavigationLink(destination: SettingsView()) {
                    //                            Image(systemName: "gearshape.fill")
                    //                            .font(.title)
                    //                            .foregroundColor(.blue)
                    //                            .padding()
                    //                                   }
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                        ForEach(user.journals, id: \.title) { journal in
                            Button(action: {
                                router.navigate(to: .detailsView)
                            }, label: {
                                JournalIconView(journal: journal)
                            })
                            
//                            NavigationLink(destination: JournalDetailView()) {
//                                JournalIconView(journal: journal)
//                            }
                        }
                    }
                    .padding([.horizontal, .bottom], 20)
                }
            }
        }
    }
}
// Preview for ProfileView using mock data
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: mockUsers[0]) // Pass a user from mockUsers
            .environment(Router())
    }
}
