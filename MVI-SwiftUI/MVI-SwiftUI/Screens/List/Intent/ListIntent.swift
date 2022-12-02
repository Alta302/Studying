//
//  ListIntent.swift
//  MVI-SwiftUI
//
//  Created by 정창용 on 2022/11/09.
//  Finish

class ListIntent {
    
    // MARK: Model
    
    private weak var model: ListModelActionsProtocol?
    private weak var routeModel: ListModelRouterProtocol?
    
    // MARK: Service
    
    private let urlService: WWDCUrlServiceProtocol
    
    // MARK: Business Data
    
    private let externalData: ListTypes.Intent.ExternalData
    private var contents: [WWDCUrlContent] = []
    
    // MARK: Life Cycle
    
    init(model: ListModelActionsProtocol & ListModelRouterProtocol,
         urlService: WWDCUrlServiceProtocol,
         externalData: ListTypes.Intent.ExternalData) {
        self.model = model
        self.routeModel = model
        self.urlService = urlService
        self.externalData = externalData
    }
}

// MARK: - Public

extension ListIntent: ListIntentProtocol {
    func viewOnAppear() {
        model?.displayLoading()
        
        urlService.fetch(content: .swiftUI) { [weak self] result in
            switch result {
            case let .success(contents):
                self?.contents = contents
                self?.model?.update(contents: contents)
                
            case let .failure(error):
                self?.model?.displayError(error)
            }
        }
    }
    
    func onTapUrlContent(id: String) {
        guard let content = contents.first(where: { $0.id == id }) else { return }
        routeModel?.routeToVideoPlayer(content: content)
    }
}

// MARK: - Helper Classes
extension ListTypes.Intent {
    struct ExternalData {}
}
