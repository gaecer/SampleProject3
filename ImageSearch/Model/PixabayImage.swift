//
//  PixabayImage.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation

struct PixabayImage {
    let id: Int
    let width: Int
    let height: Int
    let imageUrl: String
    let imageSize: Int
    
    init(dto: SearchResultHitDto) {
        self.id = dto.id
        self.width = dto.imageWidth
        self.height = dto.imageHeight
        self.imageUrl = dto.largeImageURL
        self.imageSize = dto.imageSize
    }
}

extension PixabayImage: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
}
