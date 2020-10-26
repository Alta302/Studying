//
//  ViewController.swift
//  Hansel
//
//  Created by 정창용 on 2020/10/14.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hanselTableView: UITableView!
    @IBOutlet weak var mainCell: UITableViewCell!
    
    var cellCount: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hanselTableView.delegate = self
        hanselTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        
        cell.textLabel?.text = "임시 테스트"
        
        return cell
    }

}
