//
//  Post.swift
//  MovieCorns
//
//  Created by queque on 15.03.2023.
//

import Foundation
import UIKit


struct Post: Codable {
    var id: Int
    var userFullName: String
    var userImageUrl: String
    var createdAt: String
    var likeCount: Int
    var commentCount: Int
    var postImage: String
    var postMessage: String
}
