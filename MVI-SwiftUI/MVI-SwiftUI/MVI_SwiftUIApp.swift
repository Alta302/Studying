//
//  MVI_SwiftUIApp.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//

import SwiftUI

@main
struct MVI_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ListView.build(data: .init())
        }
    }
}
