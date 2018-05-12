//
//  CategoryCell.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/7/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCellDelegate: class {
    func didSendMovieURL(_ url: String)
}

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let movieCellId = "movieCellId"
    weak var delegate: CustomCellDelegate?
    
    var movieCategory: MovieCategory! {
        didSet {
            self.sectionLabel.text = movieCategory.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        self.backgroundColor = UIColor.clear
        
        addSubview(moviesCollectionView)
        addSubview(dividerLineView)
        addSubview(sectionLabel)
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: movieCellId)
        
        sectionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14).isActive = true
        sectionLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sectionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sectionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        moviesCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor).isActive = true
        moviesCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        moviesCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        moviesCollectionView.bottomAnchor.constraint(equalTo: dividerLineView.topAnchor).isActive = true
        
        dividerLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14).isActive = true
        dividerLineView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
  
}

// MARK: - Collection View Data Source
extension CategoryCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCategory.movieItems!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! MovieCell
        cell.movie = movieCategory.movieItems![indexPath.row]
        return cell
    }
}

// MARK: - Collection View Delegate
extension CategoryCell {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieCategory.movieItems![indexPath.row]
        if let delegateObject = delegate {
            delegateObject.didSendMovieURL(movie.movieURLString)
        }
    }
}

// MARK: - Collection View Delegate Flow Layout
extension CategoryCell {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}













