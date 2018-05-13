//
//  Movie.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation

class Movie {
    
    var coverURLString: String
    var title: String
    var movieInfo: String
    var description: String
    var premiera: String
    var producers: String
    var actors: String
    var movieTrailerURL: String
    var rating: Rating?
    
    init(coverURLString: String, title: String, movieInfo: String, description: String, premiera: String, producers: String, actors: String, movieTrailerURL: String, rating: Rating?) {
        self.coverURLString = coverURLString
        self.title = title
        self.movieInfo = movieInfo
        self.description = description
        self.premiera = premiera
        self.producers = producers
        self.actors = actors
        self.movieTrailerURL = movieTrailerURL
        self.rating = rating
    }
    
    init?() {
        return nil
    }
}

class Rating {
    var numberOfVotes: String
    var averageRating: String
    
    init(numberOfVotes: String, averageRating: String) {
        self.numberOfVotes = numberOfVotes
        self.averageRating = averageRating
    }
    
    init?() {
        return nil
    }
}
