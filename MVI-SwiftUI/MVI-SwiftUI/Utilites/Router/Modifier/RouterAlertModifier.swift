//
//  RouterAlertModifier.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//  Finish

import SwiftUI
import Combine

protocol RouterAlertScreenProtocol {}

struct RouterAlertModifier<ScreenType> where ScreenType: RouterAlertScreenProtocol {
    
    // MARK: Public
    
    public let publisher: AnyPublisher<ScreenType, Never>
    public let alert: (ScreenType) -> Alert
    
    // MARK: Private
    
    @State private var screenType: ScreenType?
}

// MARK: - ViewModifier

extension RouterAlertModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onReceive(publisher) { screenType = $0 }
            .alert(
                isPresented: .init(
                    get: { screenType != nil },
                    set: { if !$0 { screenType = nil }}
                ),
                content: {
                    if let type = screenType {
                        return alert(type)
                    } else {
                        return Alert(
                            title: Text("문제가 발생하였습니다."),
                            message: nil,
                            dismissButton: .cancel()
                        )
                    }
                })
    }
}
