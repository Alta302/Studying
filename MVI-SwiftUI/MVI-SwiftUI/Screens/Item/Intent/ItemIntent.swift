//
//  ItemIntent.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import SwiftUI

class ItemIntent {
    
    // MARK: Model
    
    private weak var model: ItemModelActionsProtocol?
    private weak var routeModel: ItemModelRouterProtocol?
    
    // MARK: Business Data
    
    private let externalData: ItemTypes.Intent.ExternalData
    
    // MARK: Life Cycle
    
    init(model: ItemModelActionsProtocol & ItemModelRouterProtocol,
         externalData: ItemTypes.Intent.ExternalData) {
        self.model = model
        self.routeModel = model
        self.externalData = externalData
    }
}

// MARK: - Public

extension ItemIntent: ItemIntentProtocol {
    func viewOnAppear() {
        model?.setupScreen(url: externalData.url, title: externalData.title)
        model?.play()
    }
    
    func viewOnDisappear() {
        model?.stop()
    }
    
    func didTapPlaying() {
        model?.togglePlaing()
    }
}

// MARK: - Helper Classes

extension ItemTypes.Intent {
    struct ExternalData {
        let title: String
        let url: URL
    }
}
