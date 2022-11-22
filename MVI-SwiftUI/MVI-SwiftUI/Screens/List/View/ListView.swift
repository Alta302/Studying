//
//  ListView.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/08.
//  Finish

import SwiftUI

struct ListView: View {
    @StateObject var container: MVIContainer<ListIntentProtocol, ListModelStateProtocol>
    
    private var intent: ListIntentProtocol { container.intent }
    private var state: ListModelStateProtocol { container.model }
    
    var body: some View {
        NavigationView {
            ZStack {
                switch state.contentState {
                case .loading:
                    LoadingContent(text: state.loadingText)
                    
                case let .content(urlContents):
                    ListItems(intent: intent, urlContents: urlContents)
                    
                case let .error(text):
                    ErrorContent(text: text)
                }
            }
            .onAppear(perform: intent.viewOnAppear)
            .navigationTitle(state.navigationTitle)
            .modifier(ListRouter(subjects: state.routerSubject, intent: intent))
        }
    }
}

// MARK: - View

private extension ListView {
    
    // MARK: Loading View
    
    private struct LoadingContent: View {
        let text: String
        
        var body: some View {
            ZStack {
                Color.white
                Text(text)
            }
        }
    }
    
    // MARK: ListItems View
    
    private struct ListItems: View {
        let intent: ListIntentProtocol
        let urlContents: [ListUrlContentView.StateViewModel]
        
        var body: some View {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(urlContents, id: \.self) {
                        ListUrlContentView(state: $0, didTap: {
                            intent.onTapUrlContent(id: $0)
                        })
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
    }
    
    // MARK: ErrorView
    
    private struct ErrorContent: View {
        let text: String
        
        var body: some View {
            ZStack {
                Color.white
                Text(text)
            }
        }
    }
}

#if DEBUG

// MARK: - Previews

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView.build(data: .init())
    }
}

#endif
