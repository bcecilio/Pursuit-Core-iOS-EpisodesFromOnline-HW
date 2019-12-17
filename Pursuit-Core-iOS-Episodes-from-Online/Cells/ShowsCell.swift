//
//  ShowsCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Brendon Cecilio on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowsCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configureShowCell(for showData: ShowData) {
        showLabel.text = showData.show.name
        ratingLabel.text = showData.show.rating?.rating?.description
        // USE NETWORK HELPER!!!!!!
        showImageView.getImage(with: showData.show.image?.original ?? "") { [weak self] (result) in
            switch result {
            case .failure( _):
                DispatchQueue.main.async {
                    self?.showImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImageView.image = image
                }
            }
        }
    }
}
