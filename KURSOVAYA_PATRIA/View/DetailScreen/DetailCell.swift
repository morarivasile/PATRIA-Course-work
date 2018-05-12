//
//  DetailCell.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/11/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    var movie: Movie! {
        didSet {
             self.coverImageView.downloadImageFrom(link: movie.coverURLString, contentMode: .scaleAspectFill)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.cyan
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "legend")
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.red
        
        addSubview(coverImageView)
        
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: (self.frame.width - 16) / 2).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 1.44).isActive = true
        
        
    }
}
