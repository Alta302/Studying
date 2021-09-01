//
//  ViewController.swift
//  TestingSwift
//
//  Created by 정창용 on 2021/03/12.
//

import UIKit

class ViewController: UIViewController {
    var num1 = 1
    var num2 = 2
    
    var float: Float = 3.14
    var str: String = "안녕하세요~! ☺️"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        num1 += 1
        
        print(num1, num2)
        
        print()
        print(float, str)
        
        // print(plusNum(num: num1), plusNum(num: num2))
        
    }
    
    func plusNum(num: Int) -> Int {
        return num + 1
        
    }

}

