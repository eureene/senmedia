//
//  PlayerState.swift
//  sentnt
//
//  Created by Mohamet amine Ndiaye on 16/02/2024.
//

import Foundation
enum PlayerState {
    case stopped
    case playing
    case paused
    case loading
    case readyToPlay
    case failed(String) // Error message
}
