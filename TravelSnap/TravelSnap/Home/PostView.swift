//  PostView.swift

import SwiftUI
import FirebaseAuth

struct PostView: View {
    
    let entry: Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: entry.profilePictureURL ?? "")) { phase in
                    switch phase {
                    case .empty:
                        //this is the phase when it is loading and I put the progress view because I had to put something. (put whatever you like)
                        Image("person")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    case .failure(_):
                        // when user hasn't chosen a profile picture yet. (put whatever you like)
                        Image("person")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(entry.username ?? "User")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            
            HStack {
                Text(entry.location)
                    .font(.subheadline)
                .foregroundColor(.primary)
                
                Text(entry.timestamp, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            
            

            
            //MARK: - the description will be shown to the details View.
           // Text(entry.description)
            
            AsyncImage(url: URL(string: entry.photoURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    //same here we can use the progressView for this phase
//                    Image("SunSetMockImage")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: .infinity)
//                        .clipShape(RoundedRectangle(cornerRadius: 6))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                case .failure(_):
                    EmptyView()
                @unknown default:
//                    Text("No image")
                    EmptyView()
                }
            }
            

            
            // we can add these features next sprint if we have time or If you have time, let me know so we can work together and make it this sprint. I can add these fields to the firebase for you.
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "heart")
                    Text("\(entry.likes ?? 0) Likes")
                }
                
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
            .padding(.horizontal, 5)
            
        }
        .padding()
    }
}

#Preview {
    PostView(entry: Entry(photoURL: "", description: "", timestamp: Date(), location: "Prague", username: "Nick", profilePictureURL: ""))
}
