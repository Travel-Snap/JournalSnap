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

            AsyncImage(url: URL(string: journal.photoURL)) { phase in
                switch phase {
                case .empty:
        
                    ProgressView()
                    //for testing purposes
//                    Image("earth")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 175, height: 120)
//                        .cornerRadius(20)
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
      
        return JournalIconView(journal: Entry(photoURL: "", description: "", timestamp: Date(), location: "", userID: ""))

    }
}

