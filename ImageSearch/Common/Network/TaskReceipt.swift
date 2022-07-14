//
//  aaa.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 16/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation

/// Class to generate and cancel the task
class TaskReceipt: Cancellable {
    
    let task: URLSessionDataTask
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
    
    func cancel() {
        task.cancel()
    }
}
