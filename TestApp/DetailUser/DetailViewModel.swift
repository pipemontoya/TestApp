//
//  DetailViewModel.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import CoreLocation

protocol DetailDelegate: class {
    func albums(_ albums: [Albums])
}

class DetailViewModel {
    weak var delegate: DetailDelegate?

    let user: User
    private let api = ApiService.shared
    var albums: [Albums] {
        get {
            let realm = RealmService.shared
            guard let albums = realm.realm?.objects(Albums.self) else {return [Albums()]}
            return Array(albums).filter({$0.userId == user.id})
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    
    func getAlbums() {
        api.getAlbums {[weak self] (result) in
            switch result {
            case .success(let albums):
                _ = albums
                self?.delegate?.albums(albums)
            case .failure(let error):
                print("there was an error", error)
            }
        }
    }
    
    func createAnnotation() -> UserAnnotation {
        return UserAnnotation(
            title: "\(user.address.street) \(user.address.suite)",
            locationName: user.address.city,
            city: user.address.city,
            coordinate: CLLocationCoordinate2D(
                latitude: CLLocationDegrees(
                    exactly: Double(user.address.lat) ?? 0.0) ?? CLLocationDegrees(),
                longitude: CLLocationDegrees(
                    exactly: Double(user.address.lng) ?? 0.0) ?? CLLocationDegrees())
        )
    }
    
    func getLocation() -> CLLocation {
        return CLLocation(
            latitude: CLLocationDegrees(
                exactly: Double(user.address.lat) ?? 0.0) ?? CLLocationDegrees(),
            longitude: CLLocationDegrees(
                exactly: Double(user.address.lng) ?? 0.0) ?? CLLocationDegrees())
    }
    
}
