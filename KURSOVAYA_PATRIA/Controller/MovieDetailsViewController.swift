//
//  MovieDetailsViewController.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/9/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieItem: Movie?
    var movieURL: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        let movieClient = MovieClient()
        let htmlParser = MoviePageParser(apiClient: movieClient)
        
        htmlParser.fetchMovieDetails(movieURLString: movieURL) { (movie) in
            self.movieItem = movie
            print(movie.title)
        }
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(MovieDetailsViewController.dismissPresentViewController))
        self.navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    
    
    @objc func dismissPresentViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
