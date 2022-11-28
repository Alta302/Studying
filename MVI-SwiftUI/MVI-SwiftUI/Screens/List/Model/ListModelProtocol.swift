//
//  ListModelProtocol.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//  Finish

// MARK: - View State

protocol ListModelStateProtocol {
    var contentState: ListTypes.Model.ContentState { get }
    var loadingText: String { get }
    var navigationTitle: String { get }
    
    var routerSubject: ListRouter.Subjects { get }
}

// MARK: - Indent Actions

protocol ListModelActionsProtocol: AnyObject {
    func displayLoading()
    func update(contents: [WWDCUrlContent])
    func displayError(_ error: Error)
}

// MARK: - Route

protocol ListModelRouterProtocol: AnyObject {
    func routeToVideoPlayer(content: WWDCUrlContent)
}
