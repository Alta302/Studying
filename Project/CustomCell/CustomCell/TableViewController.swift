//
//  TableViewController.swift
//  CustomCell
//
//  Created by 정창용 on 2020/09/17.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    let timeForMatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt
            indexPath: IndexPath) -> UITableViewCell {
            let cell = CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
            
        let text: String = self.data[indexPath.row]
        cell.leftLabel?.text = text
        
        cell.rightLabel.text = timeForMatter.string(from: Data())

        return cell
        
    }
    
}

