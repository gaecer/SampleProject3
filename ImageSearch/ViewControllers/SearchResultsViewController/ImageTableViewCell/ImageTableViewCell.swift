//
//  ImageTableViewCell.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import UIKit
import Combine

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pixabayImageView: BorderedImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private(set) var viewModel: ImageTableViewCellViewModel!
    
    private var subscriptions = Set<AnyCancellable>()
    
    /// Cell Setup
    func configure(with viewModel: ImageTableViewCellViewModel) {
        self.viewModel = viewModel
        viewModel.statePublisher.sink { [weak self] state in
            self?.update(with: state)
        }
        .store(in: &subscriptions)
        viewModel.downloadImage()
    }
    
    /// update theUI with the new values
    private func update(with state: ImageTableViewCellModel) {
        pixabayImageView.image = state.image
        activityIndicator.isHidden = !state.isLoading
        if state.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    /// init properties for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions.removeAll()
        self.viewModel = nil
        self.pixabayImageView.image = nil
        self.activityIndicator.isHidden = true
    }

}
