//
//  DataFetchableProtocol.swift
//  MovieCorns
//
//  Created by queque on 17.03.2023.
//

import Foundation


protocol DataFetchableProtocol {
    associatedtype DataModel

    var data: [DataModel] { get set }

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void)
}
