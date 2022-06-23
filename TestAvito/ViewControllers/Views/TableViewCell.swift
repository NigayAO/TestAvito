//
//  TableViewCell.swift
//  TestAvito
//
//  Created by Alik Nigay on 23.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    
    func showTextCell(employee: Employee) {
        nameLabel.text = "Name: \(employee.name)"
        phoneLabel.text = "Phone: \(employee.phoneNumber)"
        skillsLabel.text = "Skills: \(employee.skills.joined(separator: ", "))"
    }
}
