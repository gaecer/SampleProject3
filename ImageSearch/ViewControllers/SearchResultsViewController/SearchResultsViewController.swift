//
//  SearchResultsViewController.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    @IBOutlet private weak var resultsTableView: UITableView!
    
    private let viewModel: SearchResultsViewModel
    
    private weak var coordinator: Coordinator?

    /// The Init use the Dependency Injection to receive the SearchResults View Model and the Coordinator
    required init?(coder: NSCoder, viewModel: SearchResultsViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.tableView = resultsTableView
    }
    
}


