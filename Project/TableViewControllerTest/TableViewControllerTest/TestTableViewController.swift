//
//  TestTableViewController.swift
//  TableViewControllerTest
//
//  Created by 정창용 on 2020/09/12.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit



class TestTableViewController: UITableViewController {
    let cellIdentifior: String = "cell"
    
    let english: [String] = ["Tiger", "Puppy", "Chameleon", "Horse", "Jaguar"]
    let korean: [String] = ["호랑이", "강아지", "카멜레온", "말", "재규어"]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.korean.count
        case 1:
            return self.english.count
        default:
            return 0
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if indexPath[0] == 0 {
            cell.textLabel?.text =
        } else {
            cell.textLabel?.text =
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2

    }

}
