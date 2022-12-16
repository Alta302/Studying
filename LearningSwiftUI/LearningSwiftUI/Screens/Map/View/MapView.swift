//
//  MapView.swift
//  LearningSwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var mapSettings = MapSettings()
    @State var mapType = 0
    @State var showElevation = 0
    @State var showEmphasis = 0
    
    var body: some View {
        ZStack {
            MapViewRepresentable()
                .edgesIgnoringSafeArea(.all)
                .environmentObject(mapSettings)
        }
        .overlay(alignment: .bottom) {
            VStack {
                Picker("Map Type", selection: $mapType) {
                    Text("Standard").tag(0)
                    Text("Hybrid").tag(1)
                    Text("Image").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: mapType) { newValue in
                    mapSettings.mapType = newValue
                }
                .padding([.top, .leading, .trailing], 16)
                
                Picker("MapElevation", selection: $showElevation) {
                    Text("Realistic").tag(0)
                    Text("Flat").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: showElevation) { newValue in
                    mapSettings.showElevation = newValue
                }
                .padding([.leading, .trailing], 16)
                
                Picker("Map Elevation", selection: $showEmphasis) {
                    Text("Default").tag(0)
                    Text("Muted").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: showEmphasis) { newValue in
                    mapSettings.showEmphasisStyle = newValue
                }
                .padding([.leading, .trailing], 16)
            }
            .background(.black)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
