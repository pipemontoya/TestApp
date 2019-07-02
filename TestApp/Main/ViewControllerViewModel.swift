//
//  ViewControllerViewModel.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation

protocol UserDelegate: class {
    func users(users: [User])
}

class ViewControllerViewModel {
    
    weak var delegate: UserDelegate?
    private let api = ApiService.shared
    var users: [User] {
        get {
            let realm = RealmService.shared
            guard let users = realm.realm?.objects(User.self) else {return [User()]}
            return Array(users)
        }
    }
    
    func getUsers() {
        api.getUsers {[weak self] (result) in
            switch result {
            case .success(let users) :
                _ = self?.users
                self?.delegate?.users(users: users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
