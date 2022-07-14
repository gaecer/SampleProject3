//
//  PixabayService.swift
//  Candyspace
//
//  Created by gaetano cerniglia on 15/03/2020.
//  Copyright © 2020 Gaetano Cerniglia. All rights reserved.
//

import Foundation


/// Errors enumeration
enum PixabayServiceError: Error {
    case invalidUrl
    case badResponseFormat
    case networkError(HttpClientError)
}

class PixabayService {
    
    typealias SearchResult = Result<[PixabayImage], PixabayServiceError>
    
    private let apiBaseUrl: String
    
    private let apiKey: String
    
    private let client: HttpClient
    
    private let cache: SearchCache
    
    init(baseUrl: String, apiKey: String, session: URLSession = .shared, cache: SearchCacheImp = .default) {
        self.apiBaseUrl = baseUrl
        self.apiKey = apiKey
        self.client = HttpClient(session: session)
        self.cache = cache
    }
    
    /**
    A function to send the call to the PixabayService to retrieve the array of Images with their informations. The funcion will try to retrieve the data from the cache first, if they are not present it will start the download, at the end it will store the downloaded data into the cache at the end.

    - parameter query: string to search
    - parameter completion: this is an escaping block of type Result<[PixabayImage], PixabayServiceError> to handle the .success or the .failure Result
    - Returns: a Cancellable object to give the option to Cancel the running calls
    */
    func searchImages(by query: String, completion: @escaping (SearchResult) -> Void) -> Cancellable? {
        guard let url = buildUrl(baseUrl: apiBaseUrl, parameters: ["key": apiKey, "q":query]) else {
            completion(.failure(.invalidUrl))
            return nil
        }
        
        /// Try to retieve the cached search results
        if let cachedData = cache.retrieveData(for: url), let cahedResult = try? JSONDecoder().decode(SearchResultDto.self, from: cachedData) {
            let images = cahedResult.hits.map { PixabayImage(dto: $0) }
            NSLog("Cache search hit!")
            DispatchQueue.main.async {completion(.success(images))}
            return nil
        }
        
        /// Download the data
        let receipt = client.getRequest(with: url) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .failure(let error): completion(.failure(.networkError(error)))
                case .success(let data):
                    do {
                        /// decode the response
                        let decoded = try JSONDecoder().decode(SearchResultDto.self, from: data)
                        let images = decoded.hits.map { PixabayImage(dto: $0) }
                        /// save downloaded data into the cache
                        self?.cache.save(data: data, for: url)
                        /// success completion
                        completion(.success(images))
                    } catch {
                        completion(.failure(.badResponseFormat))
                    }
                }
            }
        }
        
        return receipt
    }
    
    /// Utility function to build the URL appending parameter to the base URL
    private func buildUrl(baseUrl: String, parameters: [String: String]) -> URL? {
        var urlComponents = URLComponents(url: URL(string: apiBaseUrl)!, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = parameters.sorted {$0.key > $1.key }.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents.url
    }
    
}


