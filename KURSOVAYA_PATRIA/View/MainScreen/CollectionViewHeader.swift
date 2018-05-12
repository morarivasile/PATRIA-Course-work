//
//  CollectionViewHeader.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/8/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewHeader: UICollectionReusableView {
    
    var imageURL: String! {
        didSet {
            self.headerImageView.downloadImageFrom(link: imageURL, contentMode: .top, newHeight: 500)
        }
    }
    
    let headerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(headerImageView)
        
        // Add Header ImageView Constraints
        headerImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        headerImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        headerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
