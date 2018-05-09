//
//  Client.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

protocol Client {
    var session: URLSession { get }
    typealias completionHandler = (String?, APIError?) -> Void
    func fetchData(from movieFeedType: PatriaEndpoints, completionHandler completion: @escaping completionHandler)
}

