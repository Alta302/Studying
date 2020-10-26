//
//  ViewController.swift
//  MVC
//
//  Created by 정창용 on 2020/10/07.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwdTxtField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.isHidden = true
        
    }

    @IBAction func didPressLogin(_ sender: UIButton) {
        guard let email = emailTxtField.text else { return }
        guard let passwd = passwdTxtField.text else { return }
        
        user = User(email: email, passwd: passwd)
        
        if user.email == "test@naver.com" && user.passwd == "1234" {
            message.text = "로그인 성공"
            message.isHidden = false
        }
        
    }

}
