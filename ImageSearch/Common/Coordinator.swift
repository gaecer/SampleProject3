//
//  ImageCache.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

/// Coordinate the navigarion between Views
class Coordinator {
    
    private let window: UIWindow
    
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
        self.start()
    }
    
    /// Instantiate the first View Controller into a Navigation Controller
    fileprivate func start() {
        let searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchViewController") {
            let viewmodel = SearchViewModel(service: PixabayService(baseUrl: Config.apiBaseUrl, apiKey: Config.apiKey))
            return SearchViewController(coder: $0, viewModel: viewmodel, coordinator: self)
        }
        
        navigationController = UINavigationController(rootViewController: searchViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    /// Navigate to the Search Results ViewController
    func showSearchResultController(images: [PixabayImage]){
        let searchResultsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchResultsViewController") {
            let viewmodel = SearchResultsViewModel(images: images)
            return SearchResultsViewController(coder: $0, viewModel: viewmodel, coordinator: self)
        }
        
        navigationController.pushViewController(searchResultsViewController, animated: true)
    }
}
