//
//  URLSessionRequest.swift
//  rolezinho
//
//  Created by Rodrigo Santos on 14/09/17.
//  Copyright © 2017 Rodrigo. All rights reserved.
//

import Foundation

extension URLSession {
    func request(url: String) -> Future<Data> {
        let future = Future<Data>()
        
        if let urlObj = URL(string: url) {
            var request = URLRequest(url: urlObj)
            request.setValue("en-US", forHTTPHeaderField: "Accepts-Language")
            let task = dataTask(with: request) { data, _, error in
                future.result = data
            }
            task.resume()
        } else {
            future.result = nil
        }
        
        return future
    }
}
