//
//  JournalIconView.swift
//  TravelSnap
//
//  Created by Lixing Zheng on 4/13/24.
//

import SwiftUI

struct JournalIconView: View {
    
    let journal: Entry
    
    var body: some View {
        ZStack {
            //Changed it to asyncImage because the firebase gives back a string url
            AsyncImage(url: URL(string: journal.photoURL)) { phase in
                switch phase {
                case .empty:
                    // we can make it a progress view in this phase. I left it as an actual image, so we can see how it looks in the previews
                   // ProgressView()
                    Image("testImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 175, height: 120)
                        .cornerRadius(20)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 175, height: 120)
                        .cornerRadius(20)
                case .failure(_):
                    Text("No image")
                @unknown default:
                    Text("No image")
                }
            }
            
            VStack {
                Text(journal.location)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .cornerRadius(10)
                    .padding(.horizontal, 16) // Adjust as needed
                
            }
            .padding(.top, 80)
       
        }
        .frame(width: 185, height: 120)
        .shadow(radius: 5)
    }
}


struct JournalIconView_Previews: PreviewProvider {
    static var previews: some View {
      
        return JournalIconView(journal: Entry(photoURL: "", description: "", timestamp: Date(), location: "", username: "", profilePictureURL: ""))

    }
}

