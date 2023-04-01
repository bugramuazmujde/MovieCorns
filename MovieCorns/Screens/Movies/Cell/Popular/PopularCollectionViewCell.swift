//
//  PopularCollectionViewCell.swift
//  MovieCorns
//
//  Created by queque on 30.03.2023.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var popularImage: UIImageView!
    @IBOutlet weak var popularTitle: UILabel!
    @IBOutlet weak var popularYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func prepareCell(with movie:Movie){
        self.popularImage.layer.cornerRadius = 10
        self.popularImage.clipsToBounds = true
        ImageLoader.loadImage(movie.movieImage) { image in
            if let image = image {
                self.popularImage.image = image
            } else {
                print("Failed to load image")
            }
        }
        self.popularYear.text = "\(movie.movieYear)"
        self.popularTitle.text = movie.movieTitle
    }
}
