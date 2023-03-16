//
//  APIEndpoint.swift
//  MovieCorns
//
//  Created by queque on 15.03.2023.
//

import Foundation


enum APIEndpoint {
    case posts
    case movies
    
    var urlString: String {
        switch self {
        case .posts:
            return "http://www.mocky.io/v2/5dea8bf6300000d23f2b09d0"
        case .movies:
            return "http://www.mocky.io/v2/5dea8d843000001d442b09da"
        }
    }
}
