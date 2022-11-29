//
//  ListModel.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//  Finish

import SwiftUI

final class ListModel: ObservableObject, ListModelStateProtocol {
    @Published var contentState: ListTypes.Model.ContentState = .loading
    
    let loadingText: String = "Loading"
    let navigationTitle: String = "SwiftUI Video"
    let routerSubject = ListRouter.Subjects()
}

// MARK: - Actions Protocol

extension ListModel: ListModelActionsProtocol {
    func displayLoading() {
        contentState = .loading
    }
    
    func update(contents: [WWDCUrlContent]) {
        let urlContents = contents
            .map { ListUrlContentView.StateViewModel(id: $0.id, title: $0.title) }
            .sorted(by: { $0.title < $1.title })
        
        contentState = .content(urlContents: urlContents)
    }
    
    func displayError(_ error: Error) {
        contentState = .error(text: "Fail")
    }
}

// MARK: - Route Protocol

extension ListModel: ListModelRouterProtocol {
    func routeToVideoPlayer(content: WWDCUrlContent) {
        routerSubject.screen.send(.videoPlayer(title: content.title, url: content.url))
    }
}

// MARK: - Helper Classes

extension ListTypes.Model {
    enum ContentState {
        case loading
        case content(urlContents: [ListUrlContentView.StateViewModel])
        case error(text: String)
    }
}
