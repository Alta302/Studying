//
//  ContentView.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
