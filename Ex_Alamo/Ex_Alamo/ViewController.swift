//
//  ViewController.swift
//  Ex_Alamo
//
//  Created by 정창용 on 2020/11/25.
//

import UIKit

import Alamofire

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MAKE_CONTENTS()
        // Do any additional setup after loading the view.
        
    }
    
    func MAKE_CONTENTS() {
        // 접근하고자 하는 URL 정보
        let URL = "https://honggun-blog.herokuapp.com/READ_CONTENTS"

        // 전송할 파라미터 정보
        let PARAM: Parameters = [
            // "축구선수" 혹은 "영화배우"를 넣어주세요.
            "JOB": "축구선수"
            
        ]

        // 위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
        let alamo = AF.request(URL, method: .post, parameters: PARAM).validate(statusCode: 200..<300)

        // 결과값으로 JSON을 받을 때 사용
        alamo.responseJSON() { response in
            switch response.result {
            // 통신 성공
            case .success(let value):
                if let jsonObj = value as? [Dictionary<String, Any>] {
                    // JSON 배열의 갯수
                    print("데이터의 갯수: \(jsonObj.count)")
                    
                    for item in jsonObj {
                        print("\n--------------------------------------------")
                        
                        // JSON 배열의 n번째 값
                        print("item: \(item)")
                        
                        // JSON의 단일 값 접근
                        let NAME = item["NAME"]! as? String ?? ""
                        let BORN = item["BORN"]! as? Int ?? 0
                        let JOB = item["JOB"]! as? String ?? ""
                        
                        print("NAME: \(NAME)")
                        print("BORN: \(BORN)")
                        print("JOB: \(JOB)")
                        
                    }
                    
                }
                
            // 통신 실패
            case .failure(let error):
                print("error: \(String(describing: error.errorDescription))")
                
            }
            
        }
        
    }

}

