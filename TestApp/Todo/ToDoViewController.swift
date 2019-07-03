//
//  ToDoViewController.swift
//  TestApp
//
//  Created by Andres Montoya on 7/2/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ToDoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.dataSource = self
        viewModel?.getToDoList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    @objc func reload() {
        tableView.reloadData()
    }
}

extension ToDoViewController: ToDoDelegate {
    func todos(_ todos: [Todo]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCountTODOS(completed: segmentedControl.selectedSegmentIndex) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        let newTODOS = viewModel?.getTODOS(completed: segmentedControl.selectedSegmentIndex)
        cell.textLabel?.text = newTODOS?[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
