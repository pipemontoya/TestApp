//
//  DetailViewModel.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import CoreLocation

class DetailViewModel {
    
    let user: User
    
    init(user: User) {
        self.user = user
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
