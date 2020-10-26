//
//  ViewController.swift
//  Hansel
//
//  Created by 정창용 on 2020/10/20.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pwcTF: UITextField!

    override func viewDidLoad() {
        setUnderLine(pwcTF)
    }
    
    func setUnderLine (_ nameOfTextField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: nameOfTextField.frame.size.height - width, width: nameOfTextField.frame.size.width, height: nameOfTextField.frame.size.height)
    
        border.borderWidth = width
        pwcTF.layer.addSublayer(border)
        pwcTF.layer.masksToBounds = true
    }
}
