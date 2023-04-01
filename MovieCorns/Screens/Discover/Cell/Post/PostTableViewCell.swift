//
//  PostTableViewCell.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postCollectionView: UICollectionView!
    var dataSource: PostCollectionDataSource?
    var viewModel: DiscoverViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        
        dataSource = PostCollectionDataSource(with: viewModel)
        postCollectionView.dataSource = dataSource
        postCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Post")
    }
}


class PostCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let viewModel: DiscoverViewModel
        
    init(with viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Post", for: indexPath) as! PostCollectionViewCell
        
        let post = viewModel.data[indexPath.row]
        cell.prepareCell(with: post)
        return cell
    }
}
