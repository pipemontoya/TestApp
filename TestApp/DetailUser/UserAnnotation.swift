//
//  Annotation.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import MapKit

class UserAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let city: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, city: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.city = city
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
