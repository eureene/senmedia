//
//  RadioView.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import SwiftUI
import AVFoundation
import Combine
var radioPlayer: AVPlayer = AVPlayer()
var playerItem: AVPlayerItem?
struct RadioView: View {
    @State private var volume: Float = 0.5
    @ObservedObject var viewModel: TVViewModel
    @State private var selectedRadioID: String?
    @State private var playerState: PlayerState = .stopped
    @State var isLoading = false
    @State var isError = false
    let buttonBackground = Color(red: 51 / 255, green: 116 / 255, blue: 129 / 255)
    let appBackgroundColor = Color(red: 30 / 255, green: 57 / 255, blue: 50 / 255)
    let countour = Color(red: 181 / 255, green: 93 / 255, blue: 45 / 255)
    @State var statusObserver: AnyCancellable?
    @State var bufferObserver: AnyCancellable?
    
    @State
    var isPlaying = false
    var body: some View {
        NavigationView {
            
                VStack {
                    ZStack{
                        buttonBackground
                        ScrollView {
                            
                            ForEach(viewModel.radio) { channel in
                                
                                HStack {
                                    if let imageUrl = URL(string: channel.logoUrl) {
                                        AsyncImage(url: imageUrl) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(5)
                                    }
                                    Text(channel.name).foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: selectedRadioID == channel.id ? "circle.fill" : "circle")
                                        .foregroundColor(selectedRadioID == channel.id ? Color(.brown) : Color(.white))
                                    
                                    
                                }.onTapGesture {
                                    isLoading = true
                                    selectedRadioID = channel.id
                                    play(url: channel.url)
                                    
                                }

                                Rectangle()
                                    .fill(.gray)
                                           .frame(height: 1)
                                           .edgesIgnoringSafeArea(.horizontal)
                                                                }
                        }.padding(8)
                    }.cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 3)
                        )
                 
                    if(isLoading){
             
                        ProgressView()
                            
                            .scaleEffect(2) // Increase the size of the progress indicator
                            .progressViewStyle(CircularProgressViewStyle(tint: countour))
                        
                    }else if(isError) {
                        Text("radio indisponible").foregroundColor(.red)
                    }else{
                        EmptyView()
                    }
                    
                    
                    // Player control view
                    HStack {
                        Button(action: {
                            if isPlaying {
                                radioPlayer.pause()
                                isPlaying = false
                            } else {
                                radioPlayer.play()
                                isPlaying = true
                                
                            }
                        }) {
                            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .foregroundColor(isPlaying ? countour : .white)
                        }
                        Slider(value: $volume, in: 0...1, step: 0.01)
                            .onChange(of: volume) { newVolume in
                                radioPlayer.volume = newVolume
                            }
                            .accentColor(.brown) // Customize slider color
                        Image(systemName: "speaker.wave.2").foregroundColor(.white)
                    }
                    .padding()
                }
                .background(appBackgroundColor.edgesIgnoringSafeArea(.all))
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Text("Radio").foregroundColor(.white).font(.largeTitle)
                                .scaleEffect(1.1)
                                .frame(maxWidth: .infinity, alignment: .leading)

                        }
                        
                        Spacer(minLength: 20)
                    }
                }
                .onAppear{ viewModel.fetchRadio() }
          }
        
        
    }
    
    
    func play(url: String) {
        
        guard let url = URL(string: url) else {
            playerState = .failed("Invalid URL")
            return
        }
        
        playerItem = AVPlayerItem(url: url)
        radioPlayer.replaceCurrentItem(with: playerItem)
        
        
        statusObserver = playerItem?.publisher(for: \.status).sink { status in
            switch status {
            case .readyToPlay:
                radioPlayer.play()
                isPlaying = true
                isLoading = false
                isError = false
            case .failed:
                isError = true
            default:
                break
            }
        }

        bufferObserver = playerItem?.publisher(for: \.isPlaybackBufferEmpty, options: .new).sink { isEmpty in
            if isEmpty {
                isLoading = true
            } else if playerItem?.isPlaybackLikelyToKeepUp == true {
                isLoading = false
            }
        }
    }

        
 }


struct Radio: Identifiable, Decodable {
    let id: String
    let name: String
    let url: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id", name, url, logoUrl
    }
}


enum PlayerState {
    case stopped
    case loading
    case playing
    case failed(String) // Error message
}


/*if isPlaying {
    player.pause()
    isPlaying = false
} else {
    player.play()
    isPlaying = true
}
}*/
