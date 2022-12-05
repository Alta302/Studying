//
//  ItemView.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/09.
//

import AVKit
import SwiftUI

struct ItemView: View {
    @StateObject var container: MVIContainer<ItemIntentProtocol, ItemModelStateProtocol>
    
    private var intent: ItemIntentProtocol { container.intent }
    private var state: ItemModelStateProtocol { container.model }
    
    var body: some View {
        bodyView()
            .onAppear(perform: intent.viewOnAppear)
            .navigationBarTitle(state.title, displayMode: .inline)
            .modifier(ItemRouter(subjects: state.routerSubject, intent: intent))
            .onDisappear(perform: intent.viewOnDisappear)
    }
}

// MARK: - Views

private extension ItemView {
    func bodyView() -> some View {
        VStack {
            VideoPlayer(player: state.player)
            
            Button {
                self.intent.didTapPlaying()
            } label: {
                Text(state.playingText)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .padding()
    }
}

#if DEBUG

// MARK: - Previews

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let url: URL! = URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2021/10019/6/97B7FCAB-AC78-4A0D-8F28-C5C7AE8C339C/downloads/wwdc2021-10019_hd.mp4?dl=1")
        
        return ItemView.build(data: .init(title: "Discover concurrency in SwiftUI", url: url))
    }
}

#endif
