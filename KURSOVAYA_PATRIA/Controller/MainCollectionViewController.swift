//
//  MainCollectionViewController.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/7/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

private enum MainVCIdentifiers: String {
    case cellId = "cellId"
    case headerId = "collectionViewHeader"
}

class MainCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var movieCategories: [MovieCategory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.bringSubview(toFront: self.view)
        activityIndicator.startAnimating()
        
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: StretchyHeaderLayout())
        collectionView!.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        self.collectionView?.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        
        // Register our category cell.
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: MainVCIdentifiers.cellId.rawValue)
        
        // Register collection view header.
        collectionView?.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: MainVCIdentifiers.headerId.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if movieCategories.isEmpty {
            fetchCategories()
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        ai.isHidden = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    func fetchCategories() {
        let movieClient = MovieClient()
        let moviesParser = MoviesPageParser(apiClient: movieClient)
        
        moviesParser.fetchNowPlayingMovies { (categories) in
            self.movieCategories = categories
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - Collection View Data Source
extension MainCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainVCIdentifiers.cellId.rawValue, for: indexPath) as! CategoryCell
        cell.movieCategory = movieCategories[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: - Collection View Layout And interface Methods
extension MainCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainVCIdentifiers.headerId.rawValue, for: indexPath) as! CollectionViewHeader
            headerView.imageURL = "http://patria.md/beta/wp-content/uploads/flotheme/theme_bg_image.jpg"
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < -120) {
            scrollView.contentOffset.y = -120
        }
    }
}

// MARK: - Custom Cell Delegate Implementation
extension MainCollectionViewController: CustomCellDelegate {
    func didSendMovieURL(_ url: String) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let kzdmsVC = storyBoard.instantiateViewController(withIdentifier: "StoryBoardVCViewController") as! StoryBoardVCViewController
        
        let movieClient = MovieClient()
        let movieParser = MoviePageParser(apiClient: movieClient)
        
        movieParser.fetchMovieDetails(movieURLString: url) { (movie) in
            kzdmsVC.movieItem = movie
            self.navigationController?.pushViewController(kzdmsVC, animated: true)
        }
    }
}
