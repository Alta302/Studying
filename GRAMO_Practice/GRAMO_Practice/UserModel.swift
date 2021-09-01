//
//  UserModel.swift
//  GRAMO
//
//  Created by 정창용 on 2021/02/10.
//

import Foundation

final class UserModel {
    struct User {
        var username: String
        var password: String
        
    }
    
    var model: [User] = [
       User(username: "iu", password: "1234")
        
    ]
    
    // hasUser 검사 method
//    func hasUser(name: String, pwd: String) -> Bool {
//        for user in model {
//            if user.username == name && user.password == pwd {
//                return true
//                
//            }
//            
//            return false
//            
//        }
//        
//    }
        
    // newUser 추가 method
    func addUser(name: String, pwd: String) {
        let newUser = User(username: name, password: pwd)
        model.append(newUser)
        
    }

}
