//
//  WWDCUrlServiceProtocol.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/09.
//  Finish

import Foundation

protocol WWDCUrlServiceProtocol {
    func fetch(content: WWDCUrlType, completion: (Result<[WWDCUrlContent], WWDCUrlError>) -> Void)
}

enum WWDCUrlType {
    case swiftUI
}

enum WWDCUrlError: Error {
    case emptyData
}

struct WWDCUrlContent {
    var id: String { title + url.absoluteString }
    let title: String
    let url: URL
}
