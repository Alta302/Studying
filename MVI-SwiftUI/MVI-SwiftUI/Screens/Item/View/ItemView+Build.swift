//
//  ItemView+Build.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import SwiftUI

extension ItemView {
    static func build(data: ItemTypes.Intent.ExternalData) -> some View {
        let model = ItemModel()
        let intent = ItemIntent(model: model, externalData: data)
        let container = MVIContainer(
            intent: intent as ItemIntentProtocol,
            model: model as ItemModelStateProtocol,
            modelChangePublisher: model.objectWillChange)
        let view = ItemView(container: container)
        
        return view
    }
}
