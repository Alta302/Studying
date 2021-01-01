//
//  ArticleModel.swift
//  PracticeAPI
//
//  Created by 정창용 on 2021/01/01.
//  https://newsapi.org/

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(articles:[Article])
    
}

class ArticleModel {
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        // 1. 먼저 요청할 url를 string으로 담아둡니다.
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=bb8e4fcfd4bc4ea4a1ba2b1b105a592f"
        
        // 2. 해당 스트링으로 URL 인스턴스를 생성해주세요
        let url = URL(string: urlString)
        
        // 3. 해당 url이 만약에 nil 값이라면 이곳에서 중지할거에요.
        guard url != nil else {
            print("Couldn't create url object")
            
            return
        }
        
        // 4. URLSession을 만들어줍니다.
        let session = URLSession.shared
        
        // 5. URLSession을 이용해서 dataTask를 만들어줍니다.
        let datatask = session.dataTask(with: url!) { (data, response, error) in
            
            // 6. error가 없고 data를 성공적으로 불러왔을때에만 동작합니다.
            if error == nil && data != nil {
                
                // 7. JSON 데이터를 swift 인스턴스 객체로 바꿔주기 위해서 decoder 객체를 생성합니다.
                let decoder = JSONDecoder()
                
                // 8. decode함수는 예기치못한 에러를 발생할 수 있으므로 try-catch문을 작성해줍니다. swift문에서는 do-catch문이라고 불러요.
                do {
                    
                    // 9. try 문을 앞에 붙여서 JSON 데이터를 이전에 만들어준 ArticleService 모양의 swift 인스턴스로 파싱해줍니다.
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // 10. 데이터를 성공적으로 받아왔다면 일전에 만들어놓은 ArticleModelProtocol의 articlesRetrieved 함수를 이용해서 articles를 ViewController에 보내줍니다. 여기서 주의하셔야 할 점은 ArticleModel의 getArticles 함수는 background thread에서 동작하고 있습니다. 하지만 ViewController에서 articles를 받아오면 바로 화면에 띄워줘야 하기 때문에, UI관련 로직은 많은 프로세스사양을 요구하므로 main thread에서 articlesRetrieved 함수를 동작시켜주어야 합니다. 때문에 DispatchQueue.main.async 구문을 써주었습니다.
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles: articleService.articles!)
                        
                    }
                    
                } catch {
                    print("Error parsing the json")
                    
                }
                
            }
            
        }
        
        // 11. datatask 준비가 완료되었다면 datatask를 실행시켜줍니다.
        datatask.resume()
        
    }
    
}

