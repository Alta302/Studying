//
//  ItemModelProtocol.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import AVKit

// MARK: - View State

protocol ItemModelStateProtocol {
    var title: String { get }
    var playingText: String { get }
    var player: AVPlayer { get }
    var routerSubject: ItemRouter.Subjects { get }
}

// MARK: - Intent Actions

protocol ItemModelActionsProtocol: AnyObject {
    func setupScreen(url: URL, title: String)
    func play()
    func stop()
    func togglePlaing()
}

// MARK: - Route

protocol ItemModelRouterProtocol: AnyObject {
    func closeScreen()
}