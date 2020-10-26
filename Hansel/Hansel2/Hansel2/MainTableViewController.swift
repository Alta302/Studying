//
//  TableViewController.swift
//  Hansel2
//
//  Created by 정창용 on 2020/10/22.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var hanselTableView: UITableView!
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
        
    }
    
    // 뷰가 다시 나올 때 실행되는 함수
    override func viewDidAppear(_ animated: Bool) {
        hanselTableView.reloadData() // 테이블 목록을 재구성하는 코드
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! TableViewCell
        
        cell.dateLabel.text = "여기서 날짜 나옴"
        
        return cell
        
    }

}

