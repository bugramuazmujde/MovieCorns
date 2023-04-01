//
//  PostCollectionViewCell.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postCommentCount: UILabel!
    @IBOutlet weak var postLikeCount: UILabel!
    @IBOutlet weak var postProfileImage: UIImageView!
    @IBOutlet weak var postTimeAgo: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func prepareCell(with post: Post){
        ImageLoader.loadImage(post.postImage) { image in
            if let image = image {
                self.postImage.image = image
            } else {
                print("Failed to load image")
            }
        }
        ImageLoader.loadImage(post.userImageUrl) { image in
            if let image = image {
                self.postProfileImage.image = image
            } else {
                print("Failed to load image")
            }
        }
        self.postCommentCount.text = "\(post.commentCount)"
        self.postLikeCount.text = "\(post.likeCount)"
        self.postName.text = post.userFullName
        self.postDate.text = post.createdAt
        self.postTimeAgo.text = calculateTimeDifference(from: post.createdAt)
    }
    
}
