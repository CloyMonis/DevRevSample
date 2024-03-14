//
//  MovieCell.swift
//  DevRevSample
//
//  Created by Cloy Monis on 14/03/24.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    static let TAG = "MovieCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(model: MovieModel) {
        if let imageUrl = URL(string: model.mainImage)  {
            self.mainImageView.kf.setImage(with: imageUrl)
        }
        self.movieNameLabel.text = model.movieName
        self.releaseDateLabel.text = model.releaseDate
    }
}

