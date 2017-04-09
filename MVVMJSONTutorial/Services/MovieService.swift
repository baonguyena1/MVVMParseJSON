//
//  MovieService.swift
//  MVVMJSONTutorial
//
//  Created by Bao Nguyen on 4/9/17.
//  Copyright © 2017 Bao Nguyen. All rights reserved.
//

import UIKit

protocol Getable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> ())
}

struct MovieService: Getable {
    
    private let endpoint: String = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    private let downloader = JSONDownloader()
    
    //the associated type is inferred by <[Movie?]>
    typealias CurrentWeahterCompletionHandler = (Result<[Movie?]>) -> ()
    
    func get(completion: @escaping CurrentWeahterCompletionHandler) {
        guard let url = URL(string: self.endpoint) else {
            completion(.error(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = downloader.jsonTask(with: urlRequest) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .error(let error):
                    completion(.error(error))
                case .success(let json):
                    guard let movieJSONFeed = json["feed"] as? [AnyHashable: Any],
                        let entryArray = movieJSONFeed["entry"] as? [[AnyHashable: Any]] else {
                            completion(.error(.jsonParsingFailure))
                            return
                    }
                    print(entryArray)
                    let movieArray = entryArray.map { Movie(json: $0) }
                    completion(.success(movieArray))
                }
            }
        }
        task.resume()
    }
}
