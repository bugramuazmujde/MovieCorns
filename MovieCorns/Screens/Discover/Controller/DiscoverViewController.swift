//
//  DiscoverViewController.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var discoverTableView: UITableView!
    let discoverViewModel = DiscoverViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoverTableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "Story")
        discoverTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "Post")
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        
        discoverViewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.discoverTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}

extension DiscoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension DiscoverViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Story", for: indexPath) as! StoryTableViewCell
            cell.configure(with: discoverViewModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostTableViewCell
            cell.configure(with: discoverViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 195
        } else {
            return 700
        }
    }
}
