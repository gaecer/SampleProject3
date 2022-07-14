//
//  SearchViewModel.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Combine

struct SearchModel {
    var isLoading = false
    var searchQuery: String? = nil
}

class SearchViewModel {
    
    private let service: PixabayService
    
    private var searchReceipt: Cancellable? = nil
    
    private lazy var stateSubject = CurrentValueSubject<SearchModel, Never>(state)
    
    var statePublisher: AnyPublisher<SearchModel, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    var state = SearchModel() {
        didSet { stateSubject.send(state) }
    }
    
    init(service: PixabayService) {
        self.service = service
    }
    
    /**
    Function that start the search of the images setting Combine framework to observe and update changes of the response

    - parameter query: string to search
    - Returns: Publisher that contains an Array of PixabayImage objects or erros PixabayServiceError
    */
    func searchImages(by query: String) -> AnyPublisher<[PixabayImage], PixabayServiceError> {
        state.isLoading = true
        let publisher = PassthroughSubject<[PixabayImage], PixabayServiceError>()
        searchReceipt = service.searchImages(by: query) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.state.isLoading = false
            switch result {
            case .success(let searchedImages):
                publisher.send(searchedImages)
                publisher.send(completion: .finished)
            case .failure(let error):
                publisher.send(completion: .failure(error))
            }
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func cancelPendigSearch() {
        searchReceipt?.cancel()
    }
    
}
