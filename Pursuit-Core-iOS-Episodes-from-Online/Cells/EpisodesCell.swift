//
//  EpisodesCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class EpisodesCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    func configureEpisodeCell(for episodeData: EpisodeData) {
        episodeName.text = episodeData.name
        episodeLabel.text = "Episode: \(episodeData.number.description)"
        seasonLabel.text = "Season: \(episodeData.season.description)"
        
        episodeImageView.getImage(with: episodeData.image?.original ?? "") { (result) in
            switch result {
            case .failure( _):
                DispatchQueue.main.async {
                    self.episodeImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.episodeImageView.image = image
                }
            }
        }
    }
}
