//
//  RouterNavigationModifier.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//

import SwiftUI
import Combine

protocol RouterNavigationScreenProtocol {}

struct RouterNavigationModifier<Screen, ScreenType> where Screen: View, ScreenType: RouterNavigationScreenProtocol {
    
    // MARK: Public
    
    public let publisher: AnyPublisher<ScreenType, Never>
    public var screen: (ScreenType) -> Screen
    public let onDismiss: ((ScreenType) -> Void)?
    
    // MARK: Private
    
    @State private var screenType: ScreenType?
}

// MARK: - ViewModifier

extension RouterNavigationModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            NavigationLink(
                "",
                isActive: Binding<Bool> (
                    get: { screenType != nil },
                    set: {
                        if !$0 {
                            if let type = screenType { onDismiss?(type) }
                            screenType = nil
                        }
                    }),
                destination: {
                    if let type = screenType {
                        screen(type)
                    } else {
                        EmptyView()
                    }
                })
            
            content
        }
        .onReceive(publisher) { screenType = $0 }
    }
}
