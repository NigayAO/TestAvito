//
//  MainTableViewController.swift
//  TestAvito
//
//  Created by Alik Nigay on 23.06.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var employees = [Employee]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Company"
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "employee")
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employee", for: indexPath) as! TableViewCell
        let employee = employees[indexPath.row]
        cell.showTextCell(employee: employee)
        return cell
    }
}

//MARK: - Private methods
extension MainTableViewController {
    private func fetchData() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let data):
                self.employees = data.company.employees
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.title = data.company.name
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
