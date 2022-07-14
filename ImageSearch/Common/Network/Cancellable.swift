//
//  TaskRec.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation

protocol Cancellable {
    func cancel()
}

class EmptyCancellable: Cancellable {
    func cancel() {}
}
