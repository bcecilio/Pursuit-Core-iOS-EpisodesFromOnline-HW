//
//  Shows+EpisodesAPIClient.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowsSearchAPI {
    static func fetchShows(for searchQuery: String, completion: @escaping (Result<Show, AppError>)-> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "girls"
        
        let showsEndPointURL = "http://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        guard let url = URL(string: showsEndPointURL) else {
            completion(.failure(.badURL(showsEndPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(ShowData.self, from: data)
                    let shows = result.show
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
