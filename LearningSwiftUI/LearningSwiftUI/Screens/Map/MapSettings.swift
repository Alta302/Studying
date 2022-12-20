//
//  MapSettings.swift
//  LearningSwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import SwiftUI

final class MapSettings: ObservableObject {
    @Published var mapType = 0
    @Published var showElevation = 0
    @Published var showEmphasisStyle = 0
}
