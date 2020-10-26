//
//  TableData.swift
//  TableViewControllerTest
//
//  Created by 정창용 on 2020/09/14.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class TableData: NSObject, UITableViewDataSource {
    // 섹션수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 섹션별 로우수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        
        return cell
    }

}
