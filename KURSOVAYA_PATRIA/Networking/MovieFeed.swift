//
//  MovieFeed.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

enum PatriaEndpoints {
    case movies
    case news
    case movie(movie: String)
}

extension PatriaEndpoints: Endpoint {
    
    var base: String {
        return "http://patria.md"
    }
    
    var queryItems: [URLQueryItem] {
        let normalModeItem = URLQueryItem(name: "mode", value: "normal")
        return [normalModeItem]
    }
    
    var path: String {
        switch self {
        case .movies: return "/movies/"
        case .news: return "/news/"
        case.movie(let movie): return "/movies/\(movie)/"
        }
    }
}
