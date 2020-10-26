//
//  ViewController.swift
//  Hansel2
//
//  Created by 정창용 on 2020/10/22.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var startHourTF: UITextField!
    @IBOutlet weak var startMinuteTF: UITextField!
    @IBOutlet weak var finishHourTF: UITextField!
    @IBOutlet weak var finishMinuteTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var memoTV: UITextView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    // cansel 버튼을 눌렀을 때 실행되는 함수
    @IBAction func canselButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        setUnderLine(yearTF)
        setUnderLine(monthTF)
        setUnderLine(dayTF)
        setUnderLine(startHourTF)
        setUnderLine(startMinuteTF)
        setUnderLine(finishHourTF)
        setUnderLine(finishMinuteTF)
        setUnderLine(addressTF)

        memoTV.layer.borderWidth = 2.0
        memoTV.layer.borderColor = UIColor.black.cgColor
        memoTV.layer.cornerRadius = 10
        
        setLine(searchButton)
        setLine(addButton)
        
    }
    
    
    func setUnderLine (_ nameOfTextField: UITextField) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: nameOfTextField.frame.size.height - width, width: nameOfTextField.frame.size.width, height: nameOfTextField.frame.size.height)
    
        border.borderWidth = width
        
        nameOfTextField.layer.addSublayer(border)
        nameOfTextField.layer.masksToBounds = true
        
    }
    
    func setLine (_ nameOfButton: UIButton) {
        nameOfButton.layer.borderWidth = 2.0
        nameOfButton.layer.cornerRadius = 0.1 * nameOfButton.bounds.size.width
        
    }

}

