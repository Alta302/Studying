//
//  ArticleService.swift
//  PracticeAPI
//
//  Created by 정창용 on 2021/01/01.
//

import Foundation

// javascript object notation 데이터를 받아와서 swift object 데이터로 변환해주어야 한다.
// json 데이터를 Swift 객체로 만들거나, Swift 객체를 json 데이터로 변환하기 위해서 사용하는 노테이션 Codable.
struct ArticleService : Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    
}

