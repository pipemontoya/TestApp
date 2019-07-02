//
//  ViewController.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewControllerViewModel()
    lazy var refresh: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        refreshControll.tintColor = #colorLiteral(red: 0.9215686275, green: 0.3450980392, blue: 0.3607843137, alpha: 1)
        refreshControll.attributedTitle = NSAttributedString(string: "Updating Users", attributes: [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9215686275, green: 0.3450980392, blue: 0.3607843137, alpha: 1)])
        return refreshControll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.addSubview(refresh)
        tableView.dataSource = self
        tableView.delegate = self
        title = "Mad Music"
        viewModel.getUsers()
    }
    
}

///Segue destination
extension ViewController {
    
    @objc func refreshAction(_ refreshControl: UIRefreshControl) {
        viewModel.getUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            guard let user = sender as? User else {return}
            let vc = segue.destination as! DetailUserViewController
            vc.viewModel = DetailViewModel(user: user)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as? UserTableViewCell else {return UITableViewCell()}
        cell.name.text = viewModel.users[indexPath.row].name
        cell.email.text = viewModel.users[indexPath.row].email
        cell.companyURL.text = viewModel.users[indexPath.row].company.name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        performSegue(withIdentifier: "detail", sender: user)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}

extension ViewController: UserDelegate {
    func users(users: [User]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
}
