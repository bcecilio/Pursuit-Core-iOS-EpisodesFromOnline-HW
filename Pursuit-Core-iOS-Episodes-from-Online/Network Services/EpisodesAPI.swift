//
//  EpisodesAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct EpisodeAPI {
    static func fetchEpisodes(id: Int, completion: @escaping (Result<[EpisodeData], AppError>) -> ()) {
        
        let urlEpisodes = "https://api.tvmaze.com/shows/\(id)/episodes"
        
        guard let url = URL(string: urlEpisodes) else {
            completion(.failure(.badURL(urlEpisodes)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode([EpisodeData].self, from: data)
                    let episodes = result
                    completion(.success(episodes))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
