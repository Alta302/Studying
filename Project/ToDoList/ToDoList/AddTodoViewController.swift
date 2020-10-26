//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by 정창용 on 2020/09/25.
//  Copyright © 2020 정창용. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField! // 텍스트필드 선언
    @IBOutlet weak var contentTextView: UITextView! // 텍스트 뷰 선언
    
    override func viewDidLoad() {
        super.viewDidLoad() // 뷰 불러오기
        
        contentTextView.layer.borderColor = UIColor.gray.cgColor  // 테두리 색상
        contentTextView.layer.borderWidth = 0.3 // 테두리 두께
        contentTextView.layer.cornerRadius = 2.0  // 모서리 둥글게
        contentTextView.clipsToBounds = true // 글자를 잘리지 않게 해준다..?
    }
    
    // add 버튼을 눌렀을 때 실행되는 함수
    @IBAction func addListItemAction(_ sender: Any) {
        let title = titleTextField.text! // titletextfield에 있는 텍스트 변수 선언
        let content = contentTextView.text ?? "" // contenttextview에 있는 텍스트 변수 선언
        
        // 1. `Done`버튼이 클릭되었을 때 list에 데이터가 append
        let item: TodoList = TodoList(title: title, content: content)
        
        print("Add List title : \(item.title)")
        
        // TodoListViewController에 생성한 전역변수에 append
        list.append(item)
        
        // 2. 리스트화면으로 돌아가기
        self.navigationController?.popViewController(animated: true) // TodoList Scene으로 보내기
        
    }
    
    // cansel 버튼을 눌렀을 때 실행되는 함수
    @IBAction func canselButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true) // TodoList Scene으로 보내기
        
    }
    
}

