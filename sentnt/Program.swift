//
//  Program.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import Foundation
import SwiftUI



struct Program: Identifiable, Decodable {
    var id: String { title }
    let time: String
    let title: String
    
}


struct ProgramScheduleView: View {
    let programs: [Program]

    var body: some View {
        List {
            Spacer(minLength: 5)
            Text("        ******** Programme du Jour ********")
            ForEach(programs) { program in
                HStack {
                    Text(program.time)
                        .bold()
                    Text(":")
                    Text(program.title)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Program Schedule")
    }
}


let channelSchedules: [String: [Program]] = [
    "SENTV": [
    
        Program(time: "07H00", title: "BLOC MATINALE"),
        Program(time: "08H30", title: "SUBATEEL"),
        Program(time: "11H00", title: "WAXTANEKO"),
        Program(time: "13H30", title: "YENDOULENE"),
        Program(time: "15H00", title: "WONEMA"),
        Program(time: "15H00", title: "DABA BOYE SHOW"),
        Program(time: "15H00", title: "WONEMA"),
        Program(time: "17H30", title: "RENDEZ-VOUS"),
        // Add more programs as needed
    ],
    "TFM": [
        Program(time: "08H00", title: "Yewouleen"),
        Program(time: "11H00", title: "Wareef"),
        Program(time: "12H30", title: "Pub et Musique"),
        Program(time: "13H00", title: "JT"),
        Program(time: "13H30", title: "Pub et Musique"),
        Program(time: "14H00", title: "Faram Facce"),
        Program(time: "15H00", title: "Table Ya Ngoné et pub"),
        Program(time: "16H00", title: "Seetu Bi"),
        // Add more programs as needed
    ],
    // Repeat for each channel
    "WALFTV": [
        Program(time: "08H00", title: "Lici Deuk Bi"),
        Program(time: "11H00", title: "Salsalato"),
        Program(time: "12H00", title: "H24"),
        Program(time: "13H45", title: "JT"),
        Program(time: "16H30", title: "Dine Ak Diammono"),
        Program(time: "18H00", title: "Jangat"),
        Program(time: "19H30", title: "WalfQuotidien"),
        Program(time: "20H00", title: "ni moom"),
        // Add more programs as needed
    ],
    
    "2STV": [
        Program(time: "06H00", title: "kaay cover"),
        Program(time: "11H00", title: "panorama"),
        Program(time: "11H30", title: "Tribune des jeunes"),
        Program(time: "13H00", title: "EFOR"),
        Program(time: "14H30", title: "Grand Begue"),
        Program(time: "14H00", title: "Poliante"),
        Program(time: "15H00", title: "Lambji"),
        Program(time: "22H00", title: "Voix de diva"),
        // Add more programs as needed
    ],
    
    "RTS1": [
        Program(time: "06H00", title: "kaay cover"),
        Program(time: "11H00", title: "panorama"),
        Program(time: "11H30", title: "Tribune des jeunes"),
        Program(time: "13H00", title: "EFOR"),
        Program(time: "14H30", title: "Grand Begue"),
        Program(time: "14H00", title: "Poliante"),
        Program(time: "15H00", title: "Lambji"),
        Program(time: "22H00", title: "Voix de diva"),
        // Add more programs as needed
    ],
    
    "RTS2": [
        Program(time: "06H00", title: "kaay cover"),
        Program(time: "11H00", title: "panorama"),
        Program(time: "11H30", title: "Tribune des jeunes"),
        Program(time: "13H00", title: "EFOR"),
        Program(time: "14H30", title: "Grand Begue"),
        Program(time: "14H00", title: "Poliante"),
        Program(time: "15H00", title: "Lambji"),
        Program(time: "22H00", title: "Voix de diva"),
        // Add more programs as needed
    ],
    
    "BEIN SPORT 1": [
        Program(time: "06H00", title: "Emission sportive"),
        Program(time: "11H00", title: "Emission sportive"),
        Program(time: "11H30", title: "Magazine sportif"),
        Program(time: "06H00", title: "Emission sportive"),
        Program(time: "11H00", title: "Emission sportive"),
        Program(time: "11H30", title: "Magazine sportif"),
        Program(time: "16H00", title: "Emission sportive"),
        Program(time: "18H00", title: "Emission sportive"),
        Program(time: "21H30", title: "Magazine sportif"),
        // Add more programs as needed
    ],
    
    "BEIN SPORT 2": [
        Program(time: "06H00", title: "Emission sportive"),
        Program(time: "11H00", title: "Emission sportive"),
        Program(time: "11H30", title: "Magazine sportif"),
        Program(time: "06H00", title: "Emission sportive"),
        Program(time: "11H00", title: "Emission sportive"),
        Program(time: "11H30", title: "Magazine sportif"),
        Program(time: "06H00", title: "Emission sportive"),
        Program(time: "11H00", title: "Emission sportive"),
        Program(time: "11H30", title: "Magazine sportif"),
        // Add more programs as needed
    ],
]
