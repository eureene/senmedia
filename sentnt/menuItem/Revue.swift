//
//  Revue.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 29/01/2024.
//

import SwiftUI



struct Revue: View {
    
    @ObservedObject var viewModel: TVViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    let appBackgroundColor = Color(red: 30 / 255, green: 57 / 255, blue: 50 / 255)

    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
 
              
                   
                        ForEach(viewModel.revue[0].listJournaux, id: \.self) { imageUrl in
                               
                                    AsyncImage(url: URL(string: imageUrl)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }.cornerRadius(10)
                                
                                        .frame(width: 300, height: 400)
                                        .shadow(radius: 3)
                   
                        }
                }.padding(10)
                }
            
            .background(appBackgroundColor.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    HStack {
                        Text("Revue").foregroundColor(.white).font(.largeTitle)
                            .scaleEffect(1.1)
                            .frame(maxWidth: .infinity, alignment: .leading)
     
                    }
                    
                    //Spacer(minLength: 20)
                }
            }

        }
        .onAppear{ viewModel.fetchRevue() }
    }
}
struct Journal: Identifiable, Decodable {
    var id: String
    var listJournaux: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case listJournaux
    }
}
