//
//  StoryTableViewCell.swift
//  MovieCorns
//
//  Created by queque on 31.03.2023.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var storyCollectionView: UICollectionView!
    var dataSource: StoryCollectionDataSource?
    var viewModel: DiscoverViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        
        dataSource = StoryCollectionDataSource(with: viewModel)
        storyCollectionView.dataSource = dataSource
        storyCollectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Story")
    }
    
}


class StoryCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let viewModel: DiscoverViewModel
        
    init(with viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Story", for: indexPath) as! StoryCollectionViewCell
        let post = viewModel.data[indexPath.row]
        
        if indexPath.row == 0 {
            cell.prepareYou(with: post)
        } else if indexPath.row - 1 < viewModel.data.count {
            cell.prepareCell(with: post)
        }
        
        return cell
    }
}


