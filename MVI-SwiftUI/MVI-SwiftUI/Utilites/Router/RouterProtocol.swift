//
//  RouterProtocol.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//  Finish

import SwiftUI
import Combine

// MARK: - AppRouterProtocol

protocol RouterProtocol: ViewModifier {
    associatedtype RouterScreenType: RouterScreenProtocol
    associatedtype RouterAlertType: RouterAlertScreenProtocol
    associatedtype RouterScreen: View
    
    typealias Subjects = RouterSubjects<RouterScreenType, RouterAlertType>
    
    var subjects: Subjects { get }
    
    func makeScreen(type: RouterScreenType) -> RouterScreen
    func makeAlert(type: RouterAlertType) -> Alert
    
    func onDismiss(screenType: RouterScreenType)
}

extension RouterProtocol {
    func body(content: Content) -> some View {
        content
            .modifier(RouterNavigationModifier(
                publisher: subjects.screen.filter { $0.routeType == .navigationLink }.eraseToAnyPublisher(),
                screen: makeScreen,
                onDismiss: onDismiss))
            .modifier(RouterAlertModifier(
                publisher: subjects.alert.eraseToAnyPublisher(),
                alert: makeAlert))
            .modifier(RouterCloseModifier(
                publisher: subjects.close.eraseToAnyPublisher()))
            .modifier(RouterSheetModifier(
                isFullScreenCover: false,
                publisher: subjects.screen.filter { $0.routeType == .sheet }.eraseToAnyPublisher(),
                screen: makeScreen,
                onDismiss: onDismiss))
            .modifier(RouterSheetModifier(
                isFullScreenCover: true,
                publisher: subjects.screen.filter { $0.routeType == .fullScreenCover }.eraseToAnyPublisher(),
                screen: makeScreen,
                onDismiss: onDismiss))
    }
    
    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Helper Classes

struct RouterSubjects<ScreenType, AlertType> where ScreenType: RouterScreenProtocol, AlertType: RouterAlertScreenProtocol {
    let screen = PassthroughSubject<ScreenType, Never>()
    let alert = PassthroughSubject<AlertType, Never>()
    let close = PassthroughSubject<Void, Never>()
}
