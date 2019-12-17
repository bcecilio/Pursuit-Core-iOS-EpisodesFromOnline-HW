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
    
    func configureShowCell(for show: ShowData) {
        showLabel.text = show.show.name
        ratingLabel.text = show.show.rating?.rating?.description
        showImageView.getImage(with: (show.show.image?.image ?? "")) { [weak self] (result) in
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
