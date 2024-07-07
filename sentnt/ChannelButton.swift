//
//  ChannelButton.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import SwiftUI

// Define the ChannelButton view
struct ChannelButton: View {
    let channel: TVChannel

    let buttonBackground = Color(red: 51 / 255, green: 116 / 255, blue: 129 / 255)
    let channelTitle = Color(red: 181 / 255, green: 94 / 255, blue: 47 / 255)
    let countour = Color(red: 233 / 255, green: 146 / 255, blue: 99 / 255)
    
    var body: some View {
        ZStack {
            buttonBackground
            
            VStack {
                AsyncImage(url: URL(string: channel.logoUrl)) { image in
                    image.resizable()
                } placeholder: {
                    
                }.cornerRadius(5)
                .scaledToFit()
                .frame(width: 160, height: 130)
                .shadow(radius: 3)
               
            
                Text(channel.name)
                    .bold()
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(4)
                
                    
            }
        }

        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 3)
        )
    }
}
