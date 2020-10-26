//
//  ListTableViewController.swift
//  Hansel2
//
//  Created by 정창용 on 2020/10/25.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func canselButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

