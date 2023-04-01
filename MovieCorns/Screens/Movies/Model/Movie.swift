//
//  Movie.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let movieImage: String
    let movieTitle: String
    let movieYear: Int
    let movieGenre: String
    let isPopular: Bool
    let isRecommended: Bool
}
