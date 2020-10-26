//
//  TableViewController.swift
//  AutoLayout
//
//  Created by 정창용 on 2020/09/23.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let name: [String] = ["IU"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cell 1"

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomViewCell

        let text: String = self.name[indexPath.row]
            
        cell.nameLabel?.text = text

        return cell
        
    }

}
