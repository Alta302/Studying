//
//  TodoList.swift
//  TodoList
//
//  Created by 정창용 on 2021/05/11.
//

import Foundation

struct TodoList {
    var todoTitle : String = " "
    var todoText : String = " "
    
    init(todoTitle:String,todoText:String){
        self.todoTitle = todoTitle
        self.todoText = todoText
    }
}
