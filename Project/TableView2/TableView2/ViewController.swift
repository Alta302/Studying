//
//  ViewController.swift
//  TableView2
//
//  Created by 정창용 on 2020/09/16.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let address: [String] = ["화순"]
    let time: [String] = ["20:30"]
    let memo: [String] = ["집에 가고 싶어요.."]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cell 1"

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell

        let text1: String = self.address[indexPath.row]
        let text2: String = self.address[indexPath.row]
        let text3: String = self.address[indexPath.row]
            
        cell.leftLabel?.text = text1
        cell.rightLabel?.text = text2
        cell.downLabel?.text = text3

        return cell
        
    }
    
}

