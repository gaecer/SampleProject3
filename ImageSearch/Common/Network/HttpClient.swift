//
//  HttpClient.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation

enum HttpClientError: Error {
    case emptyResponse
    case requestCancelled
    case serverError
}

class HttpClient {
    
    typealias CompletionHandler = (Result<Data, HttpClientError>) -> Void
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    /**
    Generic HTTP request, the response is managed with the escaping completion block.

    - parameter url: URL address of the call
    - parameter completion: this is an escaping block of type (Result<Data, HttpClientError>) to handle the .success or the .failure Result
    - Returns: a Cancellable object to give the option to Cancel the running calls
    */
    func getRequest(with url: URL, completion: @escaping CompletionHandler) -> Cancellable? {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                if let error = error as NSError? {
                    completion(.failure(error.code == NSURLErrorCancelled ? .requestCancelled : .serverError))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyResponse))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
        return TaskReceipt(task: task)
    }
    
}
