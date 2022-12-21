//
//  ListView.swift
//  LearningSwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    NavigationLink(destination: MapView()) {
                        Text("Maps in 3D")
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                    NavigationLink(destination: ChartView()) {
                        Text("Charts")
                            .foregroundColor(.black)
                            .padding()
                    }
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
