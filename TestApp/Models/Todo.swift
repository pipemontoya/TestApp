//
//  Todo.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers
class Todo: Object {
    dynamic var userId = 0
    dynamic var id = 0
    dynamic var title = ""
    dynamic var completed = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.userId = json["userId"].intValue
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.completed = json["completed"].boolValue
    }
}
