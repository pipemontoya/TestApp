//
//  User.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class User: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var userName = ""
    dynamic var email = ""
    dynamic var phone = ""
    dynamic var website = ""
    dynamic var address: Address!
    dynamic var company: Company!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.email = json["email"].stringValue
        self.phone = json["phone"].stringValue
        self.website = json["website"].stringValue
        self.address = Address(json: json["address"])
        self.company = Company(json: json["company"])
    }
    
}
