//
//  NowPlayingParser.swift
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

class NowPlayingPageParser {
    
    let apiClient: Client
    
    init(apiClient: Client) {
        self.apiClient = apiClient
    }
    
    func fetchNowPlayingMovies(completion: @escaping (_ movieItems: [MovieItem]) -> Void) {
        print("Fetching Now Playing Movies...")
        var fetchedItems: [MovieItem] = []
    
        apiClient.fetchData(from: .movies) { (html, error) in
            
            guard let htmlString = html else { return }
            
            fetchedItems = self.parseHTMLString(htmlString, categoryWithIndex: CategoryIndex.nowPlayingCategory.rawValue)
                
            DispatchQueue.main.async {
                completion(fetchedItems)
            }
        }
    }
    
    func fetchComingSoonMovies(completion: @escaping (_ movieItems: [MovieItem]) -> Void) {
        print("Fetching Coming Soon Movies...")
        var fetchedItems: [MovieItem] = []
        
        apiClient.fetchData(from: .movies) { (html, error) in
            
            guard let htmlString = html else { return }

            fetchedItems = self.parseHTMLString(htmlString, categoryWithIndex: CategoryIndex.upcomingCategory.rawValue)
            
            DispatchQueue.main.async {
                completion(fetchedItems)
            }
        }
    }
    
    func parseHTMLString(_ HTMLString: String, categoryWithIndex index: Int) -> [MovieItem] {
        var fetchedItems: [MovieItem] = []
        
        if let doc = try? HTML(html: HTMLString, encoding: .utf8) {
            
            let movieGrid = doc.xpath("//div[@class='movie-grid'][@id='movie-grid']")[index]
            
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
                fetchedItems.append(item)
            }
        }
        return fetchedItems
    }

        
}


