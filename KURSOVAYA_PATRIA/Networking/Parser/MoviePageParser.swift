//
//  MoviePageParser.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/10/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation
import Kanna

class MoviePageParser {
    
    let apiClient: Client
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    func fetchMovieDetails(movieURLString: String, completion: @escaping (_ movie: Movie) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        
        var fetchedMovie: Movie = Movie()
        
        dispatchGroup.enter()
        
        let moviePath = NSString(string: movieURLString).lastPathComponent
//        print(PatriaEndpoints.movie(movie: moviePath).request.url?.absoluteString)
        apiClient.fetchData(from: .movie(movie: moviePath)) { (html, error) in
            guard let htmlString = html else { return }

            if let doc = try? HTML(html: htmlString, encoding: .utf8) {
                
                // Retrieving Movie Cover URL
                guard let movieBlock = doc.xpath("//div[@id='image-block']//li/img").first,
                    let movieCoverURL = movieBlock["src"] else {
                    print("Image elemenot not found on the page.")
                    return
                }
                
                // Retrieving Movie Title
                guard let movieTitle: String = doc.xpath("/html//section[@id='content']//h2[@class='title']").first?.text else {
                    print("Movie Title element not found.")
                    return
                }
                
                // Retrieving Movie Info
                guard let movieInfo: String = doc.xpath("/html//section[@id='content']//div[@class='duration']").first?.text else {
                    print("Movie Duration Element not found.")
                    return
                }
                
                // Retrieving Movie rating
                var movieRating = Rating()
                if let numberOfVotes: String = doc.xpath("/html//section[@id='content']//span[@class='post-ratings']//strong[1]").first?.content,
                    let averageRating: String = doc.xpath("/html//section[@id='content']//span[@class='post-ratings']//strong[2]").first?.content {
                    movieRating = Rating(numberOfVotes: numberOfVotes, averageRating: averageRating)
                } else {
                    movieRating = Rating()
                }
                
                // Retrieving Movie Description
                guard let movieDescription: String = doc.xpath("/html//section[@id='content']/div[@class='movie-content']//div[@class='excerpt']/p").first?.content else {
                    print("Movie Description Element Not Found.")
                    return
                }
                
                // Retrieving Movie Producers
                guard let movieProducers: String = doc.xpath("/html//section[@id='content']//div[@class='story']//div[@class='add-param'][1]").first?.content else {
                    print("Movie Producers Element Not found.")
                    return
                }
                
                // Retrieving Movie Actors
                guard let movieActors: String = doc.xpath("/html//section[@id='content']//div[@class='story']//div[@class='add-param'][2]").first?.content else {
                    print("Movie Actors Element not found")
                    return
                }
                
                guard let moviePremiere: String = doc.xpath("/html//section[@id='content']//div[@class='premiere']").first?.content else {
                    print("Movie Premiere element not found.")
                    return
                }
                
                fetchedMovie = Movie(coverURLString: movieCoverURL, title: movieTitle, movieInfo: movieInfo, description: movieDescription, premiera: moviePremiere, producers: movieProducers, actors: movieActors, rating: movieRating)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(fetchedMovie)
        }
    }
    
}
