//
//  ViewController.swift
//  AlertPractice
//
//  Created by 정창용 on 2020/10/08.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func alertAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "Alert" {
            showAlert(style: .alert)
        } else {
            showAlert(style: .actionSheet)
        }
        
    }
    
    func showAlert(style: UIAlertController.Style) {
        let alert = UIAlertController(title: "배고프다", message: "곧 저녁 먹겠지..?", preferredStyle: style)
        
        let success = UIAlertAction(title: "그르지", style: .default)
        let cancel = UIAlertAction(title: "그른가", style: .cancel)
        let destructive = UIAlertAction(title: "그르겠지..?", style: .destructive)
        
        alert.addAction(success)
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

