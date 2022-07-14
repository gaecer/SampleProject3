//
//  SearchResult.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation

struct SearchResultDto: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [SearchResultHitDto]
}
