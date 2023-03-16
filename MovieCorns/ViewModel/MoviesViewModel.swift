//
//  MoviesViewModel.swift
//  MovieCorns
//
//  Created by queque on 15.03.2023.
//

import Foundation


class MoviesViewModel {
    var movies = [Movie]()

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
       APIManager.shared.fetchData(from: APIEndpoint.movies.urlString, returnType: [Movie].self) { [weak self] result in
           switch result {
           case .success(let movies):
               self?.movies = movies
               completion(.success(()))
           case .failure(let error):
               completion(.failure(error))
           }
       }
   }
}
