//
//  ViewController.swift
//  PracticeAPI
//
//  Created by 정창용 on 2021/01/01.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    var model = ArticleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        model.getArticles()
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 여기서 주의하셔야 할 점은 tableView에서 불러온 identifier가 ArticleCell인 인스턴스는 단순한 UITableViewCell이 아니라 저희가 커스텀한 ArticleCell입니다. 캐스팅으로 ArticleCell임을 명시해주세요. 그렇지 않다면 단순 UITableViewCell로만 인식할 것입니다
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let article = self.articles[indexPath.row]
        
        // TODO: customize it
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController: ArticleModelProtocol {
    // MARK: ArticleModelProtocol functions
    func articlesRetrieved(articles: [Article]) {
        print("articles retrieved from aricle model!")
        
        self.articles = articles
        
        tableView.reloadData()
        
    }
    
}

