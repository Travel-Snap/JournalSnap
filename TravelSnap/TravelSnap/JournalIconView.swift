//
//  JournalIconView.swift
//  TravelSnap
//
//  Created by Lixing Zheng on 4/13/24.
//

import SwiftUI

struct JournalIconView: View {
    let journal: JournalEntry
    
    var body: some View {
        ZStack {
            Image(journal.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 175, height: 120)
                .cornerRadius(20)
            
            VStack {
                Text(journal.title)
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
        let journal = JournalEntry(title: "Place one", image: "MorningWalkMockImage", caption: "This is", date:"some date", location:"some location")
        return JournalIconView(journal: journal)

    }
}

