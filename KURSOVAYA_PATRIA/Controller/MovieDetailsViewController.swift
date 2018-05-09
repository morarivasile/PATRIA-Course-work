//
//  MovieDetailsViewController.swift
//  KURSOVAYA_PATRIA
//
//  Created by Vasile Morari on 5/9/18.
//  Copyright © 2018 Vasile Morari. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieURL: String! {
        didSet {
            print(movieURL)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
    }


}
