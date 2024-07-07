//
//  RediffusionView.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import SwiftUI
import YouTubePlayerKit

struct RediffusionView: View {
    
    @ObservedObject var viewModel: TVViewModel

    let appBackgroundColor = Color(red: 30 / 255, green: 57 / 255, blue: 50 / 255)
    let buttonBackground = Color(red: 51 / 255, green: 116 / 255, blue: 129 / 255)
    let channelTitle = Color(red: 181 / 255, green: 94 / 255, blue: 47 / 255)
    let countour = Color(red: 233 / 255, green: 146 / 255, blue: 99 / 255)
    @State var reloadYoutubePlayer = false
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeigh = UIScreen.main.bounds.height/3.7

    var body: some View {
    
        NavigationView {
            
            VStack {
                
                YouTubePlayerView(viewModel.youTubePlayer) { state in
                    // Overlay ViewBuilder closure to place an overlay View
                    // for the current `YouTubePlayer.State`
                    switch state {
                    case .idle:
                        ProgressView()
                    case .ready:
                        EmptyView()
                    case .error(_):
                        Button("Recharger") {
                            viewModel.reloadYouTubePlayer()
                        }
                        .padding() // Adds padding inside the specified frame size
                        .frame(width: 200, height: 50) // Controls the button's overall size
                        .foregroundColor(.white) // Sets the text color to white
                        .background(countour) // Example background color for contrast                        .border(countour, width: 1) // Adds a gray border to make the
                        .cornerRadius(10) // Adds rounded corners
             
                    }
                }.frame(width: screenWidth, height: 220)
                    .aspectRatio(contentMode: .fit)
                ScrollView {
                    ForEach(viewModel.rediffusion, id: \.id) { channel in
                        VStack(alignment: .leading) {
                            Text(channel.name) // This is the channelTitle
                                .font(.headline)
                                .foregroundColor(.white)
                              
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    
                                    ForEach(channel.videos, id: \.id) { video in
                                        ZStack{
                                            buttonBackground
                                            VStack {
                                                
                                                if let url = URL(string: video.thumbnailUrl) {
                                                    AsyncImage(url: url) { image in
                                                        image.resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                    } placeholder: {
                                                        Color.gray.frame(width: 150, height: 90)
                                                    }
                                                    .frame(width: 150, height: 90) // Width and height for the thumbnail
                                                    .cornerRadius(8)
                                                    .clipped()
                                                    .onTapGesture {
                                                        // When thumbnail is tapped, update the YouTubePlayer source
                                                        viewModel.youTubePlayer.source = .video(id: video.id)
                                                    }
                                                }
                                                Text(video.title) // This is the title for each video
                                                    .foregroundColor(.white)
                                                    .bold()
                                                    .font(.caption)
                                                    .multilineTextAlignment(.leading)
                                                    .lineLimit(5) // Max lines
                                                    .truncationMode(.tail) // Truncate with an ellipsis
                                                    .frame(width: 150, height: 70) // Match the width of the thumbnail
                                                  
                                                    
                                            }.padding(3)
                                            
                                        }
                                    }
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 3)
                                    )
                                }
                            }
                        }.padding(.horizontal, 8)
                        
                    }
                }
            }
            .background(appBackgroundColor.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    HStack {
                        Text("Rediffusion").foregroundColor(.white).font(.largeTitle)
                            .scaleEffect(1.1)
                            .frame(maxWidth: .infinity, alignment: .leading)
     
                    }
                    
                    Spacer(minLength: 20)
                }
            }
        }.onAppear{ 
        viewModel.fetchRediffusion()

        }
        
    }
}





struct Rediffusion: Identifiable, Decodable {
    let id: String
    let name: String
    var videos: [VideoItem]
    var rang: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"  // Map the "_id" key in JSON to the "id" property
        case name
        case videos
        case rang
    }
}

struct VideoItem: Identifiable, Decodable {
    let id: String
    let title: String
    let thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "videoId"
        case title
        case thumbnailUrl
    }
}
