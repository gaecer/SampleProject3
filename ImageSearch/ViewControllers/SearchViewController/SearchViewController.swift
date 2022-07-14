//
//  ViewController.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    private var searchView: SearchView { return view as! SearchView }
    
    private let viewModel: SearchViewModel
    
    private lazy var subscriptions = Set<AnyCancellable>()
    
    private weak var coordinator: Coordinator?
    
    /// The Init use the Dependency Injection to receive the Search View Model and the Coordinator
    required init?(coder: NSCoder, viewModel: SearchViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.statePublisher
            .assign(to: \.state, on: searchView)
            .store(in: &subscriptions)
        /// bind UI Events touchUpInside and editingChanged
        searchView.searchButton.addTarget(self, action: #selector(didPressSearchButton(_:)), for: .touchUpInside)
        searchView.searchTextField.addTarget(self, action: #selector(searchTextFiledDidChange(_:)), for: .editingChanged)
    }
    
    /// This function is triggered on Tap inside the Search Button. The function fill start the search of the images function in the ViewModel, it will push to the Search Result View Controller in case of success
    @objc
    private func didPressSearchButton(_ sender: UIButton) {
        guard let query = viewModel.state.searchQuery else { return }
        viewModel.searchImages(by: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: NSLog("request completed")
                case .failure(let error): NSLog("\(error)")
                }
            }, receiveValue: { [weak self] images in
                self?.coordinator?.showSearchResultController(images: images)
            })
            .store(in: &subscriptions)
    }
    /// This function is triggered on changes of the Text Field text to bind the text to the View Model
    @objc
    private func searchTextFiledDidChange(_ sender: UITextField) {
        viewModel.state.searchQuery = sender.text
    }
}

