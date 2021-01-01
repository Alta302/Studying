//
//  ArticleCell.swift
//  PracticeAPI
//
//  Created by 정창용 on 2021/01/01.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var headLineText: UILabel!
    @IBOutlet weak var headLineImage: UIImageView!
    
    var articleToDisplay: Article?
    
    func displayAritcle(article: Article) {
        articleToDisplay = article
        
        headLineText.text = articleToDisplay!.title
        
        // 이미지 url이 없는 기사가 있을 수도 있습니다. image url이 없다면 그냥 여기서 함수를 종료시켜줍니다.
        guard articleToDisplay!.urlToImage != nil else {
            return
            
        }
        
        let urlString = articleToDisplay!.urlToImage!
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create url object")
            return
            
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) {(data, response, error) in
            if (error == nil && data != nil) {
                // image를 변경하는 작업은 UI를 변경시키는 작업이므로 main thread에서 돌려주어야 합니다.
                DispatchQueue.main.async {
                    self.headLineImage.image = UIImage(data: data!)
                    
                }
                
            }
            
        }
        
        dataTask.resume()
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}

