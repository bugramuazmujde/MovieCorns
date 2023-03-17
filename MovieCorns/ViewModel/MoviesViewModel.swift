//
//  MoviesViewModel.swift
//  MovieCorns
//
//  Created by queque on 15.03.2023.
//

import Foundation


class MoviesViewModel: DataFetchableProtocol {
    typealias DataModel = Movie

    var data = [Movie]()

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
       APIManager.shared.fetchData(from: APIEndpoint.movies.urlString, returnType: [Movie].self) { [weak self] result in
           switch result {
           case .success(let movies):
               self?.data = movies
               completion(.success(()))
           case .failure(let error):
               completion(.failure(error))
           }
       }
   }
}
