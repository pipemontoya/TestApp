//
//  photos.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

@objcMembers
class Photos: Object {
    dynamic var albumId = 0
    dynamic var id = 0
    dynamic var title = ""
    dynamic var url = ""
    dynamic var thumbnailUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.albumId = json["albumId"].intValue
        self.id = json["id"].intValue
        self.url = json["url"].stringValue
        self.title = json["title"].stringValue
        self.thumbnailUrl = json["thumbnailUrl"].stringValue
    }
}
