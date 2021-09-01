//
//  ViewController.swift
//  GRAMO_Practice
//
//  Created by 정창용 on 2021/02/18.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.idTF.becomeFirstResponder()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.idTF.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.idTF.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        
        return true
        
    }

}

