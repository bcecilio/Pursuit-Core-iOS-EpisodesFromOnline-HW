//
//  EpisodesData.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct EpisodeData: Decodable {
    let name: String
    let season: Int
    let number: Int
    let image: [Images]
}

struct Images: Decodable {
    let medium: String
    let original: String
}
