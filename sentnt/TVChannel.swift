//
//  TVChannel.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 26/01/2024.
//

import Foundation

struct TVChannel: Identifiable, Decodable {
    var id: String { _id }
    let _id: String
    let name: String
    let url: String
    let playerType: String
    let logoUrl: String
    let rang: Int
}
