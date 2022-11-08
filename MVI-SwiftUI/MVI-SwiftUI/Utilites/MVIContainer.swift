//
//  MVIContainer.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//

import SwiftUI
import Combine

final class MVIContainer<Intent, Model>: ObservableObject {
    
    // MARK: Public
    
    public let intent: Intent
    public let model: Model
    
    // MARK: private
    
    private var cancellable: Set<AnyCancellable> = []
    
    // MARK: Life Cycle
    
    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model
        
        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}
