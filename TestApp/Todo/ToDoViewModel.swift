//
//  ToDoViewModel.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation

protocol ToDoDelegate: class {
    func todos(_ todos: [Todo])
}

class ToDoViewModel {
    weak var delegate: ToDoDelegate?
    let user: User!
    private let api = ApiService.shared
    var toDos: [Todo] {
        get {
            let realm = RealmService.shared
            guard let todos = realm.realm?.objects(Todo.self) else {return [Todo()]}
            return Array(todos).filter({$0.userId == user.id})
        }
    }
    init(user: User) {
        self.user = user
    }
    
    func getToDoList() {
        api.getToDoList {[weak self] (result) in
            switch result {
            case .success(let todos):
                _ = todos
                self?.delegate?.todos(todos)
            case .failure(let error):
                print("there was an error", error)
            }
        }
    }
    func getCountTODOS(completed: Int) -> Int {
        return completed == 0 ? toDos.filter({$0.completed}).count : toDos.filter({$0.completed == false}).count
    }
    func getTODOS(completed: Int) -> [Todo] {
        return completed == 0 ? toDos.filter({$0.completed}) : toDos.filter({$0.completed == false})
    }
}
