//
//  RecommendedTableViewCell.swift
//  MovieCorns
//
//  Created by queque on 30.03.2023.
//

import UIKit


class RecommendedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    var dataSource: RecommendedCollectionDataSource?
    var viewModel: MoviesViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        
        dataSource = RecommendedCollectionDataSource(with: viewModel)
        recommendedCollectionView.dataSource = dataSource
        recommendedCollectionView.register(UINib(nibName: "RecommendedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Recommended")
    }
}


class RecommendedCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let viewModel: MoviesViewModel
        
    init(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.filter{ $0.isRecommended }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Recommended", for: indexPath) as! RecommendedCollectionViewCell
        
        let movie = viewModel.data[indexPath.row]
        cell.prepareCell(with: movie)
        return cell
    }
}
