//
//  Address.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class Address: Object {
    
    dynamic var street = ""
    dynamic var suite = ""
    dynamic var city = ""
    dynamic var zipcode = ""
    dynamic var lat = ""
    dynamic var lng = ""
    
    
    convenience init(json: JSON) {
        self.init()
        self.street = json["street"].stringValue
        self.suite = json["suite"].stringValue
        self.city = json["city"].stringValue
        self.zipcode = json["zipcode"].stringValue
        self.lat = json["geo"]["lat"].stringValue
        self.lng = json["geo"]["lng"].stringValue
    }
}
