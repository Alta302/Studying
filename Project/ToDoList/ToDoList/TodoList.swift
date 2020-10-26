//
//  TodoList.swift
//  ToDoList
//
//  Created by 정창용 on 2020/09/25.
//  Copyright © 2020 정창용. All rights reserved.
//

import Foundation

struct TodoList {
    var title: String = ""  // 할일 제목
    var content: String?    // 할일 세부 내용
    var isComplete: Bool = false  // 할일 완료 여부
 
    init(title: String, content: String?, isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
        
    }
    
}

