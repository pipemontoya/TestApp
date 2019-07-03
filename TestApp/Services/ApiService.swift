//
//  ApiService.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiService {
    static let shared = ApiService()
    private let realm = RealmService.shared
    
    func getUsers(handler: @escaping (Result<[User], Error>) -> Void) {
        var users = [User]()
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let content = data else {
                print("without data")
                return
            }
            let json = JSON(content)
            for user in json {
                users.append(User(json: user.1))
            }
            self?.realm.save(objects: users)
            handler(.success(users))
        }
        task.resume()
    }
    
    func getAlbums(handler: @escaping (Result<[Albums], Error>) -> Void) {
        var albums = [Albums]()
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let content = data else {
                print("without data")
                return
            }
            let json = JSON(content)
            for album in json {
                albums.append(Albums(json: album.1))
            }
            self?.realm.save(objects: albums)
            handler(.success(albums))
        }
        task.resume()
    }
    
    func getPhotos(handler: @escaping (Result<[Photos], Error>) -> Void) {
        var photos = [Photos]()
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let content = data else {
                print("without data")
                return
            }
            let json = JSON(content)
            for album in json {
                photos.append(Photos(json: album.1))
            }
            self?.realm.save(objects: photos)
            handler(.success(photos))
        }
        task.resume()
    }
    
}
