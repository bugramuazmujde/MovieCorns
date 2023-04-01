//
//  MoviesViewController.swift
//  MovieCorns
//
//  Created by queque on 30.03.2023.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    let moviesViewModel = MoviesViewModel()
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.register(UINib(nibName: "RecommendedTableViewCell", bundle: nil), forCellReuseIdentifier: "Recommended")
        moviesTableView.register(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "Popular")
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        moviesViewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.moviesTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Recommended", for: indexPath) as! RecommendedTableViewCell
            cell.configure(with: moviesViewModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Popular", for: indexPath) as! PopularTableViewCell
            cell.configure(with: moviesViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 390
        } else {
            return 295
        }
    }
}
