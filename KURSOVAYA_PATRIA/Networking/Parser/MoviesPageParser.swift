//
//  MoviesPageParser.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/6/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation
import Kanna

private enum CategoryIndex: Int {
    case nowPlayingCategory = 0
    case upcomingCategory = 2
}

class MoviesPageParser {
    
    let apiClient: Client
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    func fetchNowPlayingMovies(completion: @escaping (_ movieCategoryes: [MovieCategory]) -> Void) {
        print("Fetching Now Playing Movies...")
        var fetchedCategories: [MovieCategory] = []
        
        apiClient.fetchData(from: .movies) { (html, error) in
            
            guard let htmlString = html else { return }
            
            fetchedCategories = self.parseHTMLString(htmlString)
            
            DispatchQueue.main.async {
                completion(fetchedCategories)
            }
        }
    }
    
    func parseHTMLString(_ HTMLString: String) -> [MovieCategory] {
        var fetchedCategoryes: [MovieCategory] = []
        if let doc = try? HTML(html: HTMLString, encoding: .utf8) {
            
            let categoryIndexes = [0, 2]
            
            for index in categoryIndexes {
                
                let movieGrid = doc.xpath("//div[@class='movie-grid'][@id='movie-grid']")[index]
                
                let movieCategory: MovieCategory = MovieCategory()
                
                if index == 0 {
                    movieCategory.name = "Now Playing"
                } else if index == 2 {
                    movieCategory.name = "Upcoming"
                }
                
                for movieIndex in 1...10 {
                    let movieItem = movieGrid.at_xpath("div[@class='movies-item'][\(movieIndex)]")
                    
                    guard let figure = movieItem?.at_xpath("figure/a"),
                        let posterPath = movieItem?.at_xpath("figure/a/img") else {
                            print("MovieItem not found on the page!")
                            return []
                    }
                    
                    guard let movieTitle: String = figure["title"] else {
                        print("Movie Title not found on the page!")
                        return []
                    }
                    guard let movieURL: String = figure["href"] else {
                        print("Movie URL not found on the page!")
                        return []
                    }
                    guard let coverURL: String = posterPath["src"]else {
                        print("Cover URL not found on the page!")
                        return []
                    }
                    
                    let item = MovieItem(title: movieTitle, movieURLString: movieURL, posterPath: coverURL)
                    movieCategory.movieItems?.append(item)
                }
                fetchedCategoryes.append(movieCategory)
            }
           
        }
        return fetchedCategoryes
    }
    
    
}


