//
//  PopularTableViewCell.swift
//  MovieCorns
//
//  Created by queque on 30.03.2023.
//

import UIKit


class PopularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    var dataSource: PopularCollectionDataSource?
    var viewModel: MoviesViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        
        dataSource = PopularCollectionDataSource(with: viewModel)
        popularCollectionView.dataSource = dataSource
        popularCollectionView.register(UINib(nibName: "PopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Popular")
    }
}


class PopularCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let viewModel: MoviesViewModel
        
    init(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.filter{ $0.isPopular }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Popular", for: indexPath) as! PopularCollectionViewCell
        
        let movie = viewModel.data[indexPath.row]
        cell.prepareCell(with: movie)
        return cell
    }
}
