//
//  DetailAlbumViewController.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit
import Kingfisher

class DetailAlbumViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: DetailAlbumViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getPhotos()
        viewModel?.delegate = self
        collectionView.dataSource = self
    }

}

extension DetailAlbumViewController: DetailAlbumDelegate {
    func photos(_ photos: [Photos]) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}

extension DetailAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? AlbumCollectionViewCell else {return UICollectionViewCell()}
        let url = URL(string: viewModel?.photos[indexPath.row].thumbnailUrl ?? "")
        cell.albumImage.kf.setImage(with: url)
        return cell
    }
    
    
}

