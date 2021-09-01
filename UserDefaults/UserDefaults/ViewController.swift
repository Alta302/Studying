//
//  ViewController.swift
//  UserDefaults
//
//  Created by 정창용 on 2021/05/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSwitch.isOn = UserDefaults.standard.bool(forKey: "switchState")
    }
    
    @IBAction func didTapSwitch(_ sender: UISwitch) {
        UserDefaults.standard.set(testSwitch.isOn, forKey: "switchState")
    }
}
