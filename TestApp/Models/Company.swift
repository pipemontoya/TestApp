//
//  Company.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class Company: Object {
    
    dynamic var name = ""
    dynamic var catchphrase = ""
    dynamic var bs = ""
    
    convenience init(json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.catchphrase = json["catchPhrase"].stringValue
        self.bs = json["bs"].stringValue
    }
}
