//
//  MoviesViewController.swift
//  MovieCorns
//
//  Created by queque on 12.03.2023.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesRecomTitle: UILabel! // Recommended For You Title
    @IBOutlet weak var moviesPopTitle: UILabel!

    @IBOutlet weak var movieRecomCollectionView: UICollectionView!
    
    @IBOutlet weak var movieRecomFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var moviePopularCollectionView: UICollectionView!
    
    @IBOutlet weak var moviePopularFlowLayout: UICollectionViewFlowLayout!
    
    let moviesViewModel = MoviesViewModel()
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To avoid the "UICollectionView.reloadData() must be used from main thread only" error
        // Make sure to call collectionView.reloadData() on the main thread
        moviesViewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.movieRecomCollectionView.reloadData()
                    self?.moviePopularCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
        
        moviesPopTitle.text = "Popular"
        // To make bold first word of recommended movies title
        moviesRecomTitle.attributedText = setCustomRecomTitle()
        
        movieRecomCollectionView.dataSource = self
        movieRecomCollectionView.delegate = self
        moviePopularCollectionView.dataSource = self
        moviePopularCollectionView.delegate = self
    }

    @IBAction func moviesRecomViewAll(_ sender: Any) {
    }
    
    @IBAction func moviesPopViewAll(_ sender: Any) {
        
    }
    
    func setCustomRecomTitle() -> NSMutableAttributedString {
        let text = "Recommended For You"
        let attributedString = NSMutableAttributedString(string: text)
        let firstWordRange = (text as NSString).range(of: text.components(separatedBy: " ")[0])

        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: firstWordRange)
        return attributedString
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.movieRecomCollectionView {
            return moviesViewModel.data.filter{ $0.isRecommended }.count
        } else if collectionView == self.moviePopularCollectionView {
            return moviesViewModel.data.filter{ $0.isPopular }.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.movieRecomCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesRecomCell", for: indexPath) as! MoviesRecomCollectionViewCell

            let movie = moviesViewModel.data.filter{ $0.isRecommended }[indexPath.row]
            let genreScrollView = UIScrollView(frame: cell.movieRecomGenreView.bounds)
            let genre = UILabel(frame: CGRect(x: 0, y: 0, width: cell.movieRecomGenreView.bounds.width, height: 0))
            
            cell.movieRecomImage.layer.cornerRadius = 10
            cell.movieRecomImage.clipsToBounds = true
            cell.movieRecomTitle.text = movie.movieTitle
            cell.movieRecomYear.text = "\(movie.movieYear)"
            genre.text = movie.movieGenre
            genre.numberOfLines = 0
            genre.sizeToFit()
            genreScrollView.contentSize = genre.bounds.size
            genreScrollView.addSubview(genre)
            cell.movieRecomGenreView.addSubview(genreScrollView)
            
            loadImage(movie.movieImage) { image in
                cell.movieRecomImage.image = image
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesPopularCell", for: indexPath) as! MoviesPopularCollectionViewCell
            let movie = moviesViewModel.data.filter{ $0.isPopular }[indexPath.row]
            cell.moviePopularImage.layer.cornerRadius = 10
            cell.moviePopularImage.clipsToBounds = true
            cell.moviePopularTitle.text = movie.movieTitle
            cell.moviePopularYear.text = "\(movie.movieYear)"
            
            loadImage(movie.movieImage) { image in
                cell.moviePopularImage.image = image
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.movieRecomCollectionView {
            let width = movieRecomCollectionView.frame.width * 0.4
            let height = movieRecomCollectionView.frame.height
            return CGSize(width: width, height: height)
        } else {
            let width = moviePopularCollectionView.frame.width * 0.4
            let height = moviePopularCollectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

extension MoviesViewController {
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

