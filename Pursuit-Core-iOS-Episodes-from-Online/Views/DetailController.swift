//
//  DetailController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var episodeDetail: EpisodeData!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let episodeInfo = episodeDetail else {
            print("could not load episode info")
            return
        }
        episodeTitleLabel.text = episodeInfo.name
        episodeLabel.text = episodeInfo.number.description
        descriptionLabel.text = "\(episodeInfo.summary ?? "")"
        
        episodeImageView.getImage(with: episodeDetail.image?.original ?? "") { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.episodeImageView.image = image
                }
            }
        }
    }
}
