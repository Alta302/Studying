//
//  ChartView.swift
//  LearningSwiftUI
//
//  Created by 정창용 on 2022/11/10.
//

import Charts
import SwiftUI

struct Posting: Identifiable {
    let name: String
    let count: Int
  
    var id: String { name }
}

let postings: [Posting] = [
    .init(name: "Green", count: 250),
    .init(name: "James", count: 100),
    .init(name: "Tony", count: 70)
]

struct ChartView: View {
    var body: some View {
        Chart {
            ForEach(postings) { posting in
                LineMark(
                    x: .value("Name", posting.name),
                    y: .value("Posing", posting.count)
                )
                .symbol(by: .value("Name", posting.name))
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
