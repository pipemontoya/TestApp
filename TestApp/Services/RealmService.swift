//
//  RealmService.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService: NSObject {
    static let shared = RealmService()
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func save<T: Object>(object: T, update: Bool = true) {
        do {
            try realm?.write {
                realm?.add(object, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func save<T: Object>(objects: [T], update: Bool = true) {
        do {
            try realm?.write {
                realm?.add(objects, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    func update<T: Object>(object: T?, with dictionary: [String: Any?]) {
        guard let object = object else {
            return
        }
        do {
            try realm?.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }

}
