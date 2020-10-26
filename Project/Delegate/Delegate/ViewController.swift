//
//  ViewController.swift
//  Delegate
//
//  Created by 정창용 on 2020/09/16.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var hiTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiTextField.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hiLabel.text = hiTextField.text
        return true

    }
    
}

