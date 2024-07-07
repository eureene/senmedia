//
//  AppViewModel.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import Foundation
import Combine
import AVKit
import YouTubePlayerKit

class TVViewModel: ObservableObject {
    @Published var channels: [TVChannel] = []
    @Published var selectedChannel: TVChannel?
    @Published var adConfig: AdConfiguration?
    @Published var showSchedule = false
    @Published var selectedChannelSchedule: [Program]? = nil
    @Published var clickCount = 0
    @Published var reloadYoutubePlayer = false
 
    @Published var rediffusion: [Rediffusion] = []
    @Published var radio: [Radio] = []
    @Published var revue: [Journal] = []
    @Published var youTubePlayer: YouTubePlayer = ""



    private var cancellableSet: Set<AnyCancellable> = []
    

    init() {
        fetchConfiguration()
        fetchChannels()
        fetchRediffusion()
        fetchRadio()
        fetchRevue()
        // Use streamURL here

        youTubePlayer
            .objectWillChange
            .sink { }
    }

    func fetchChannels() {
        guard let url = URL(string: "https://app.leatdev.com:72/channels") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: [TVChannel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    print("Error fetching channels: \(error)")
                    self?.channels = []
                }
            }, receiveValue: { [weak self] fetchedChannels in
                self?.channels = fetchedChannels.sorted { $0.rang < $1.rang }
            })
            .store(in: &cancellableSet)
    }

    func fetchConfiguration() {
        guard let url = URL(string: "https://app.leatdev.com:72/appConfig") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [AdConfiguration].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Error fetching configuration: \(error)")
                }
            }, receiveValue: { [weak self] configArray in
                self?.adConfig = configArray.first
            })
            .store(in: &cancellableSet)
    }

    func fetchRediffusion() {
        guard let url = URL(string: "https://app.leatdev.com:71/rediffusion") else { return }

               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       print("Network error: \(error)")
                       return
                   }

                   guard let data = data else {
                       print("No data received")
                       return
                   }

                   do {
                       let decodedResponse = try JSONDecoder().decode([Rediffusion].self, from: data)
                       DispatchQueue.main.async {
                           self.rediffusion = decodedResponse
                           print("Data loaded successfully")
                       }
                   } catch {
                       print("JSON Decoding error: \(error)")
                   }
               }.resume()
           }
    
    
    func fetchRevue() {
        guard let url = URL(string: "https://app.leatdev.com:71/revue") else { return }

               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       print("Network error: \(error)")
                       return
                   }

                   guard let data = data else {
                       print("No data received")
                       return
                   }

                   do {
                       let decodedResponse = try JSONDecoder().decode([Journal].self, from: data)
                       DispatchQueue.main.async {
                           self.revue = decodedResponse
                           print("Data loaded successfully")
                       }
                   } catch {
                       print("JSON Decoding error: \(error)")
                   }
               }.resume()
           }
    
    
    func fetchRadio() {
        guard let url = URL(string: "https://app.leatdev.com:71/radio") else { return }

               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       print("Network error: \(error)")
                       return
                   }

                   guard let data = data else {
                       print("No data received")
                       return
                   }

                   do {
                       let decodedResponse = try JSONDecoder().decode([Radio].self, from: data)
                       DispatchQueue.main.async {
                           self.radio = decodedResponse
                           print("Data loaded successfully")
                       }
                   } catch {
                       print("JSON Decoding error: \(error)")
                   }
               }.resume()
           }
    
    
    func reloadYouTubePlayer() {
        guard let videoId = rediffusion.first?.videos.first?.id else { return }
        youTubePlayer.source = .video(id: videoId)
        youTubePlayer.reload()
    }
    

        
}


