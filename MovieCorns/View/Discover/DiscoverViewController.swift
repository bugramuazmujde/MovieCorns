//
//  DiscoverViewController.swift
//  MovieCorns
//
//  Created by queque on 12.03.2023.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    
    @IBOutlet weak var discoverStoryCollectionView: UICollectionView!
    @IBOutlet weak var discoverStoryFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var discoverPostCollectionView: UICollectionView!
    @IBOutlet weak var discoverPostFlowLayout: UICollectionViewFlowLayout!
    
    let discoverViewModel = DiscoverViewModel()
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverViewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.discoverStoryCollectionView.reloadData()
                    self?.discoverPostCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
        
        discoverStoryCollectionView.dataSource = self
        discoverStoryCollectionView.delegate = self
        discoverPostCollectionView.dataSource = self
        discoverPostCollectionView.delegate = self
    }
}

extension DiscoverViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == discoverStoryCollectionView {
            return discoverViewModel.data.count + 1
        } else {
            return discoverViewModel.data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.discoverStoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverStoryCell", for: indexPath) as! DiscoverStoryCollectionViewCell

            if indexPath.row == 0 {
                cell.discoverStoryName.text = "You"
                cell.discoverStoryImage.image = UIImage(named: "videoCall")
                cell.discoverStoryImage.contentMode = .scaleToFill
            } else if indexPath.row - 1 < discoverViewModel.data.count {
                let post = discoverViewModel.data[indexPath.row - 1]
                cell.backgroundColor = UIColor.clear
                cell.discoverStoryName.text = post.userFullName
                
                loadImage(post.userImageUrl) { image in
                    cell.discoverStoryImage.image = image
                }
            }
            cell.discoverStoryImage.layer.cornerRadius = cell.discoverStoryImage.frame.size.width / 2
            cell.discoverStoryImage.clipsToBounds = true
            cell.discoverStoryImage.layer.borderWidth = 3.0
            cell.discoverStoryImage.layer.borderColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1).cgColor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverPostCell", for: indexPath) as! DiscoverPostCollectionViewCell
            let post = discoverViewModel.data[indexPath.row]
            cell.discoverPostName.text = post.userFullName
            cell.discoverPostCreatedDate.text = post.createdAt
            cell.discoverPostLikes.text = String(post.likeCount)
            cell.discoverPostComments.text = String(post.commentCount)
            cell.discoverPostTimeAgo.text = discoverViewModel.calculateTimeDifference(from: post.createdAt)
            cell.discoverPostProfileImage.layer.cornerRadius = 45
            cell.discoverPostProfileImage.clipsToBounds = true
            
            loadImage(post.postImage) { image in
                cell.discoverPostImage.image = image
            }

            loadImage(post.userImageUrl) { image in
                cell.discoverPostProfileImage.image = image
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.discoverStoryCollectionView {
            return CGSize(width: 100, height: 110)
        } else {
            let width = discoverPostCollectionView.frame.width
            let height = discoverPostCollectionView.frame.height * 0.8
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension DiscoverViewController {
    func loadImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let image = imageCache.object(forKey: NSString(string: urlString)) {
            completion(image)
        } else {
            let url = URL(string: urlString)!
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        self?.imageCache.setObject(image, forKey: NSString(string: urlString))
                        completion(image)
                    }
                }
            }
            task.resume()
        }
    }
}
