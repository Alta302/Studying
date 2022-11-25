//
//  ListRouter.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//

import SwiftUI

struct ListRouter: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen
    
    let subjects: Subjects
    let intent: ListIntentProtocol
}

// MARK: - Navigation Screens

extension ListRouter {
    enum ScreenType: RouterScreenProtocol {
        case videoPlayer(title: String, url: URL)
        
        var routeType: RouterScreenPresentationType {
            switch self {
            case .videoPlayer:
                return .navigationLink
            }
        }
    }
    
    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
         switch type {
         case let .videoPlayer(title, url):
             ItemView.build(data: .init(title: title, url: url))
         }
    }
    
    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alert

extension ListRouter {
    enum AlertScreen: RouterAlertScreenProtocol {
        case defaultAlert(title: String, message: String?)
    }
    
     func makeAlert(type: RouterAlertType) -> Alert {
         switch type {
         case let .defaultAlert(title, message):
             return Alert(title: Text(title),
                          message: message.map { Text($0) },
                          dismissButton: .cancel(Text("Cancel")))
         }
     }
}
