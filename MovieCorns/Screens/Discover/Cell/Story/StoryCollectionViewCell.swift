//
//  StoryCollectionViewCell.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.storyImage.layer.cornerRadius = storyImage.frame.size.width / 2
        self.storyImage.clipsToBounds = true
        self.storyImage.layer.borderWidth = 3.0
        self.storyImage.layer.borderColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1).cgColor
    }
    
    func prepareYou(with post:Post){
        self.storyTitle.text = "You"
        self.storyImage.image = UIImage(named: "videoCall")
    }
    
    func prepareCell(with post: Post){
        ImageLoader.loadImage(post.userImageUrl) { image in
            if let image = image {
                self.storyImage.image = image
            } else {
                print("Failed to load image")
            }
        }
        self.storyTitle.text = post.userFullName
    }
    
}
