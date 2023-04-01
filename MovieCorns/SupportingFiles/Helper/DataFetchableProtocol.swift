//
//  DataFetchableProtocol.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import Foundation

protocol DataFetchableProtocol {
    associatedtype DataModel

    var data: [DataModel] { get set }

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void)
}
