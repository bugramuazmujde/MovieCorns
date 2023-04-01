//
//  Post.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation


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
