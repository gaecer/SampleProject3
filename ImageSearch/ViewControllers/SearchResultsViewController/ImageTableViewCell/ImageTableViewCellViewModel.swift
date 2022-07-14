//
//  ImageTableViewCellModel.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation
import UIKit
import Combine

/// Cell Model
struct ImageTableViewCellModel {
    var isLoading: Bool = false
    var image: UIImage
}

class ImageTableViewCellViewModel {
    
    let pixabayImage: PixabayImage
    
    var state: ImageTableViewCellModel {
        didSet { /// On new image received send the notificatio to the subcribers
            stateSubject.send(state)
        }
    }
    
    private var placeholderImage: UIImage
    
    private lazy var imageDownloader = ImageDownloader.default
    
    private var currentDownload: Cancellable?
    
    init(pixabayImage: PixabayImage) {
        self.pixabayImage = pixabayImage
        self.placeholderImage = UIImage(named: "logo.png")!
        self.state = ImageTableViewCellModel(image: placeholderImage)
    }
    
    private lazy var stateSubject = CurrentValueSubject<ImageTableViewCellModel, Never>(state)
    
    var statePublisher: AnyPublisher<ImageTableViewCellModel, Never> {
        return stateSubject.eraseToAnyPublisher()
    }
    
    func downloadImage() {
        let url = URL(string: pixabayImage.imageUrl)!
        state.isLoading = true
        currentDownload = imageDownloader.image(at: url, fallbackImage: placeholderImage) { [weak self] in
            self?.state.isLoading = false
            self?.state.image = $0
        }
    }
    
    func cancelDownload() {
        currentDownload?.cancel()
    }
    
}

extension ImageTableViewCellViewModel: Hashable {
    
    static func == (lhs: ImageTableViewCellViewModel, rhs: ImageTableViewCellViewModel) -> Bool {
        return lhs.pixabayImage == rhs.pixabayImage    }
    
    
    func hash(into hasher: inout Hasher) { hasher.combine(pixabayImage.id) }
    
}
