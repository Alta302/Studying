//
//  SecondViewController.swift
//  TodoList
//
//  Created by 정창용 on 2021/05/11.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var Maintitle: UITextField!
    @IBOutlet weak var Content: UITextView!
    
    @IBAction func cancelItem(_ sender : UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DoneItem(_ sender: UIBarButtonItem) {
        let title = Maintitle.text!
        let content = Content.text!
        
        let item: TodoList = TodoList(todoTitle: title, todoText: content)
    
        todolist.append(item)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
