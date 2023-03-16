//
//  PostsViewModel.swift
//  MovieCorns
//
//  Created by queque on 15.03.2023.
//

import Foundation


class DiscoverViewModel {
    var posts = [Post]()

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
       APIManager.shared.fetchData(from: APIEndpoint.posts.urlString, returnType: [Post].self) { [weak self] result in
           switch result {
           case .success(let posts):
               self?.posts = posts
               completion(.success(()))
           case .failure(let error):
               completion(.failure(error))
           }
       }
    }
    
    func calculateTimeDifference(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        guard let postDate = dateFormatter.date(from: dateString) else {
            return nil // invalid date format
        }
        
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second], from: postDate, to: now)
        
        if let years = components.year, years >= 1 {
            return "\(years) years later"
        } else if let months = components.month, months >= 1 {
            return "\(months) mounts later"
        } else if let weeks = components.weekOfYear, weeks >= 1 {
            return "\(weeks) weeks later"
        } else if let days = components.day, days >= 1 {
            return "\(days) days later"
        } else if let hours = components.hour, hours >= 1 {
            return "\(hours) hours later"
        } else if let minutes = components.minute, minutes >= 1 {
            return "\(minutes) minutes later"
        } else {
            return "Now"
        }
    }

}
