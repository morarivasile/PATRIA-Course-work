//
//  MovieClient.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

class MovieClient: Client {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchData(from endpoint: PatriaEndpoints, completionHandler completion: @escaping completionHandler) {
        
        let request = endpoint.request
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    let HTMLString = String(data: data, encoding: String.Encoding.utf8)
                    completion(HTMLString, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        task.resume()
    }
}
