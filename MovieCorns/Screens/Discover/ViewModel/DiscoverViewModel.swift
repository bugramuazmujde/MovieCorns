//
//  DiscoverViewModel.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation


class DiscoverViewModel: DataFetchableProtocol {
    typealias DataModel = Post
    
    var data = [Post]()

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
       APIManager.shared.fetchData(from: APIEndpoint.posts.urlString, returnType: [Post].self) { [weak self] result in
           switch result {
           case .success(let posts):
               self?.data = posts
               completion(.success(()))
           case .failure(let error):
               completion(.failure(error))
           }
       }
    }
}
