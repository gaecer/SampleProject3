//
//  SearchView.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var activityStackView: UIStackView!
    
    var state: SearchModel = SearchModel() {
        didSet { updateView() }
    }
    
    private func updateView() {
        /// Enable - Disable search button
        searchButton.isEnabled = {
            guard let q = state.searchQuery else { return false }
            return !q.isEmpty && !state.isLoading
        }()
        activityStackView.isHidden = !state.isLoading
        searchTextField.isEnabled = !state.isLoading
    }
    
}
