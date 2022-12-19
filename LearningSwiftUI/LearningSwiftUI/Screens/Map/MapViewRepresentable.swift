//
//  MapViewRepresentable.swift
//  LearningSwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import MapKit
import SwiftUI

struct MapViewRepresentable: UIViewRepresentable {
    @EnvironmentObject private var mapSettings: MapSettings
    
    private var counter = 0
    private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.3811, longitude: 4.6373),
                                               span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.region = mapRegion
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateMapType(uiView)
    }
}

private extension MapViewRepresentable {
    private func updateMapType(_ uiView: MKMapView) {
        switch mapSettings.mapType {
        case 0:
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: elevationStyle(), emphasisStyle: emphasisStyle())
            
        case 1:
            uiView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: elevationStyle())
            
        case 2:
            uiView.preferredConfiguration = MKImageryMapConfiguration(elevationStyle: elevationStyle())
            
        default:
            break
        }
    }
    
    private func elevationStyle() -> MKMapConfiguration.ElevationStyle {
        if mapSettings.showElevation == 0 {
            return MKMapConfiguration.ElevationStyle.realistic
        } else {
            return MKMapConfiguration.ElevationStyle.flat
        }
    }
    
    private func emphasisStyle() -> MKStandardMapConfiguration.EmphasisStyle {
        if mapSettings.showEmphasisStyle == 0 {
            return MKStandardMapConfiguration.EmphasisStyle.default
        } else {
            return MKStandardMapConfiguration.EmphasisStyle.muted
        }
    }
}
