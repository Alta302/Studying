//
//  RouterCloseModifier.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/09.
//  Finish

import SwiftUI
import Combine

struct RouterCloseModifier: ViewModifier {
    
    // MARK: Public
    
    public let publisher: AnyPublisher<Void, Never>
    
    // MARK: Private
    
    @Environment(\.presentationMode) private var presentationMode
    
    func body(content: Content) -> some View {
        content
            .onReceive(publisher) { _ in
                presentationMode.wrappedValue.dismiss()
            }
    }
}
