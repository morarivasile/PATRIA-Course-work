//
//  StoryBoardVCViewController.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/11/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class StoryBoardVCViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieInfoLabel: UILabel!
    @IBOutlet weak var movieCoverImageView: UIImageView!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieProducersTestView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var movieActorsLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movieItem: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreenElements()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)

    }

    @objc func screenEdgeSwiped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupScreenElements() {
        movieTitleLabel.text = movieItem.title
        movieInfoLabel.text = movieItem.movieInfo
        movieCoverImageView.downloadImageFrom(link: movieItem.coverURLString, contentMode: .scaleAspectFill)
        if movieItem.rating == nil {
            movieRatingLabel.text = "No rating yet"
        } else {
            let nrOfVotes = movieItem.rating?.numberOfVotes
            let averageRating = movieItem.rating?.averageRating
            movieRatingLabel.text = "\(nrOfVotes!) votes | Avg - \(averageRating!) / 10.0"
        }
        
        movieProducersTestView.text = movieItem.producers
        movieActorsLabel.text = movieItem.actors
        movieDescriptionLabel.text = movieItem.description
    }

}
