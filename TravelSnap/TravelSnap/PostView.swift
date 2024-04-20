//  PostView.swift

import SwiftUI
import FirebaseAuth

struct PostView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: post.userProfilePictureURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .border(Color.black)
                
                Text(post.username)
                
                Spacer()
            }
            
            Text(post.timestamp, style: .date)
            
            Text(post.caption)
            
            AsyncImage(url: post.photoURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 200)
            .border(Color.black)
            
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "heart")
                    Text("\(post.likes.count) Likes")
                }
                
                Spacer()
                
                Button(action: {
                }) {
                    Image(systemName: "bubble.left")
                    Text("\(post.comments.count) Comments")
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
    PostView(post: Post(userID: "", username: "Lia", userProfilePictureURL: nil, photoURL: nil, caption: "", timestamp: Date(), likes: [], comments: []))
}
