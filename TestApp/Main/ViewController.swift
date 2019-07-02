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
    var resultSearchController = UISearchController()
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
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Search By Name"
            controller.searchBar.barTintColor = #colorLiteral(red: 0.9215686275, green: 0.3450980392, blue: 0.3607843137, alpha: 1)
            controller.searchBar.tintColor = #colorLiteral(red: 0.937254902, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
            definesPresentationContext = true
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        tableView.reloadData()
        viewModel.delegate = self
        tableView.addSubview(refresh)
        tableView.dataSource = self
        tableView.delegate = self
        title = "Mad Music"
        viewModel.getUsers()
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return resultSearchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        viewModel.usersFiltered = viewModel.users.filter({( user : User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return resultSearchController.isActive && !searchBarIsEmpty()
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
        if isFiltering() {
            return viewModel.usersFiltered.count
        } else {
            return viewModel.users.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as? UserTableViewCell else {return UITableViewCell()}
        if isFiltering() {
            cell.name.text = viewModel.usersFiltered[indexPath.row].name
            cell.email.text = viewModel.usersFiltered[indexPath.row].email
            cell.companyURL.text = viewModel.usersFiltered[indexPath.row].website
        } else {
            cell.name.text = viewModel.users[indexPath.row].name
            cell.email.text = viewModel.users[indexPath.row].email
            cell.companyURL.text = viewModel.users[indexPath.row].website
        }
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
