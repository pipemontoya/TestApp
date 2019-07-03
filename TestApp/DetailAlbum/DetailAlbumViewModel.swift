//
//  DetailAlbumViewModel.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation

protocol DetailAlbumDelegate: class {
    func photos(_ photos: [Photos])
}

class DetailAlbumViewModel {
    
    weak var delegate: DetailAlbumDelegate?
    let album: Albums
    private let api = ApiService.shared
    var photos: [Photos] {
        get {
            let realm = RealmService.shared
            guard let photos = realm.realm?.objects(Photos.self) else {return [Photos()]}
            return Array(photos).filter({$0.albumId == album.id})
        }
    }
    
    init(album: Albums) {
        self.album = album
    }
    
    func getPhotos() {
        api.getPhotos {[weak self] (result) in
            switch result {
            case .success(let photos):
                _ = photos
                self?.delegate?.photos(photos)
            case .failure(let error):
                print("there was an error", error)
            }
        }
    }
    
}
