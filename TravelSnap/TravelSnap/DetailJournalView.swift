//
//  DetailJournalView.swift
//  TravelSnap
//
//  Created by Lixing Zheng on 4/19/24.
//

import SwiftUI



struct JournalDetailView: View {
    
    let journal: JournalEntry = mockUsers[0].journals[0]
    
    var body: some View {

            VStack (alignment: .leading){
                // Display the image associated with the journal entry
                Image(journal.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(journal.title)
                    .font(.title)
                    .fontWeight(.bold) // Make the text bold
                    .padding(.horizontal) // Add padding to the text
                
                HStack(alignment: .center){
                    Image(systemName: "mappin.circle.fill") // Marker icon
                        .font(.system(size: 50))
                        .foregroundColor(.gray) // Set color to blue
                        .padding(.trailing) // Add trailing padding to separate from the text
                    VStack{
                        Text(journal.title)
                            .font(.title)
                            .padding(.horizontal) // Add padding to the text
                        Text(journal.date)
                            .font(.title)
                            .padding(.horizontal) // Add padding to the text
                            .foregroundColor(.blue)
                        Text(journal.location)
                            .font(.title)
                            .padding(.horizontal) // Add padding to the text
                            .foregroundColor(.blue)
                    }
                    
                }
                Text(journal.caption)
                    .font(.title)
                    .padding(.horizontal) // Add padding to the text
                
                
                HStack{
                    Spacer()
                    // Delete Entry Button
                    Button(action: {
                        // Placeholder action for delete entry
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.black)
                            Text("Delete this entry")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .padding(.horizontal)
            //.navigationBarItems(trailing:
            //              NavigationLink(destination: EditJournalView(journal: journal)) {
            // Image(systemName: "pencil")
            //   .font(.title)
            // .foregroundColor(.blue)
            //.padding()
            //            }
            //)
            .navigationBarTitle(journal.title)
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct JournalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the JournalDetailView with a mock journal entry
        JournalDetailView()
    }
}

