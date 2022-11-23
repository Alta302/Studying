//
//  ListView+Build.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/09.
//  Finish

import SwiftUI

extension ListView {
    static func build(data: ListTypes.Intent.ExternalData) -> some View {
        let model = ListModel()
        let intent = ListIntent(model: model, urlService: WWDCUrlService(), externalData: data)
        let container = MVIContainer(
            intent:intent as ListIntentProtocol,
            model: model as ListModelStateProtocol,
            modelChangePublisher: model.objectWillChange)
        let view = ListView(container: container)
        
        return view
    }
}
