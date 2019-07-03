//
//  RealmMigrationService.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMigrationService {
    
    static func migration() {
        let migrationID = 2
        let config = Realm.Configuration(
            schemaVersion: UInt64(migrationID),
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < migrationID) {
                    
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}
