import AVKit
import AppTrackingTransparency
import FirebaseMessaging
import Combine
import Foundation
import SwiftUI
import IronSource
import FirebaseCore
import FBAudienceNetwork
import YouTubePlayerKit

func configureAudioSession() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback)
        try AVAudioSession.sharedInstance().setActive(true)
    } catch {
        print("Failed to set audio session category. Error: \(error)")
    }
}



struct ContentView: View {
    @State private var selectedTab = 0
    @StateObject private var viewModel = TVViewModel()
    let countour = Color(red: 181 / 255, green: 93 / 255, blue: 45 / 255)
    init() {
        // Set the default colors for the tab bar items
        UITabBar.appearance().unselectedItemTintColor = UIColor.brown
    }
    
    var body: some View {
        let lastContentType = viewModel.adConfig?.contentType[3]
        if (lastContentType != "live"){
            TVView(viewModel: viewModel)
        }else{
            
            TabView(selection: $selectedTab) {
                
               TVView(viewModel: viewModel)
                    .tabItem {
                        Label("TV", systemImage: "tv")
                    }
                    .tag(0)

                RediffusionView(viewModel: viewModel)
                
                    .tabItem {
                        Label("Rediffusion", systemImage: "play.tv") // Example icon
                    }
                    .tag(1)

                RadioView(viewModel: viewModel)
                    .tabItem {
                        Label("Radio", systemImage: "radio")
                    }
                    .tag(2)

                Revue(viewModel: viewModel)
                    .tabItem {
                        Label("Revue", systemImage: "newspaper.fill")
                    }
                    .tag(3)

            }.onChange(of: selectedTab) { newValue in
                if newValue != 0 {  // Assuming the TV view is at tab index 0
                    player.pause()
                }
          
            }
            
        }
    
    }
}



// Preview provider for SwiftUI previews



extension UIApplication {
    var currentWindow: UIWindow? {
        guard let windowScene = connectedScenes.first as? UIWindowScene else { return nil }
        return windowScene.windows.first { $0.isKeyWindow }
    }
}
