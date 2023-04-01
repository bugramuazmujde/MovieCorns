//
//  RecommendedCollectionViewCell.swift
//  MovieCorns
//
//  Created by queque on 30.03.2023.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var recomImage: UIImageView!
    @IBOutlet weak var recomGenre: UILabel!
    @IBOutlet weak var recomYear: UILabel!
    @IBOutlet weak var recomTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareCell(with movie:Movie){
        self.recomImage.layer.cornerRadius = 10
        self.recomImage.clipsToBounds = true
        ImageLoader.loadImage(movie.movieImage) { image in
            if let image = image {
                self.recomImage.image = image
            } else {
                print("Failed to load image")
            }
        }
        self.recomGenre.text = movie.movieGenre
        self.recomYear.text = "\(movie.movieYear)"
        self.recomTitle.text = movie.movieTitle
    }

}
