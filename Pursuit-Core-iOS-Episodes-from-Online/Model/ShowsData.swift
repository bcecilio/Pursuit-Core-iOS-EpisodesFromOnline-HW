//
//  ShowsData.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowData: Decodable {
    let show: [Show]
}

struct Show: Decodable {
    let name: String
    let type: String
    let rating: Rating
    let image: Image
    let summary: String
}

struct Rating: Decodable {
    let rating: Double
}

struct Image: Decodable {
    let image: String
    let original: String
}


