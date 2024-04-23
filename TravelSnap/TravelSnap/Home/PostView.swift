//  PostView.swift

import SwiftUI
import FirebaseAuth

struct PostView: View {
    
    let entry: Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: entry.profilePictureURL ?? "")) { phase in
                    switch phase {
                    case .empty:
                        //this is the phase when it is loading and I put the progress view because I had to put something. (put whatever you like)
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    case .failure(_):
                        // when user hasn't chosen a profile picture yet. (put whatever you like)
                        Image("person")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .border(Color.black)
                    @unknown default:
                        Text("No image")
                    }
                }
                Text(entry.username ?? "User")
                    .foregroundStyle(.blue)
                
                Spacer()
            }
            
            Text(entry.timestamp, style: .date)
            //MARK: - the description will be shown to the details View.
           // Text(entry.description)
            
            AsyncImage(url: URL(string: entry.photoURL)) { phase in
                switch phase {
                case .empty:
                    //same here we can use the progressView for this phase
                    Image("SunSetMockImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 200)
                        .border(Color.black)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 200)
                        .border(Color.black)
                case .failure(_):
                    Text("No image")
                @unknown default:
                    Text("No image")
                }
            }
            
            // we can add these features next sprint if we have time or If you have time, let me know so we can work together and make it this sprint. I can add these fields to the firebase for you.
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "heart")
                    Text("\(entry.likes ?? 0) Likes")
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "bubble.left")
                    Text("\(entry.comments?.count ?? 0) Comments")
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
            }
            .foregroundColor(.secondary)
            .font(.caption)
            .padding()
        }
        .padding()
    }
}

#Preview {
    PostView(entry: Entry(photoURL: "", description: "", timestamp: Date(), location: "", username: "Nick", profilePictureURL: ""))
}
