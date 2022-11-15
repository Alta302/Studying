//
//  RouterScreenProtocol.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//  Finish

protocol RouterScreenProtocol: RouterNavigationScreenProtocol & RouterSheetScreenProtocol {
    var routeType: RouterScreenPresentationType { get }
}

enum RouterScreenPresentationType {
    case navigationLink
    case sheet
    case fullScreenCover
}
