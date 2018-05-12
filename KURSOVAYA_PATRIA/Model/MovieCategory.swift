//
//  MovieCategory.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/8/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

class MovieCategory {
    
    var name: String?
    var movieItems: [MovieItem]?
    
    init(name: String, movieItems: [MovieItem]) {
        self.name = name
        self.movieItems = movieItems
    }
    
    init() {
        self.name = ""
        self.movieItems = []
    }
}
