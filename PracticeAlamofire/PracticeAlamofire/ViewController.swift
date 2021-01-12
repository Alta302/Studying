//
//  ViewController.swift
//  PracticeAlamofire
//
//  Created by 정창용 on 2021/01/12.
//

import UIKit

class ViewController: UIViewController {
    let urlString = "https://api.androidhive.info/contacts/"
    let tableView = UITableView()
    var dataSourse: [Contect] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
        
    }

}

