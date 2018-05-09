//
//  Movie.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

class MovieItem: Decodable {
    
    let title: String
    let movieURLString: String
    let posterPath: String
    
    init(title: String, movieURLString: String, posterPath: String) {
        self.title = title
        self.movieURLString = movieURLString
        self.posterPath = posterPath
    }
    
}
