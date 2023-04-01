//
//  APIManager.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation


class APIManager {
    
    static let shared = APIManager()
    
    func fetchData<T: Codable>(from url: String, returnType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.invalidJSON))
            }
        }.resume()
    }
    
    enum APIError: Error {
        case invalidURL
        case invalidData
        case invalidJSON
        case invalidResponse
    }
}
