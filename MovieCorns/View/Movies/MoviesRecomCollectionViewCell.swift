//
//  MoviesRecomCollectionViewCell.swift
//  MovieCorns
//
//  Created by queque on 13.03.2023.
//

import UIKit

class MoviesRecomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieRecomImage: UIImageView!
    @IBOutlet weak var movieRecomTitle: UILabel!
    @IBOutlet weak var movieRecomGenreView: UIView!
    @IBOutlet weak var movieRecomYear: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // scrollView content cleaning
        for subview in movieRecomGenreView.subviews {
            subview.removeFromSuperview()
        }
    }
}
