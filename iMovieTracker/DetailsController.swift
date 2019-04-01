//
//  DetailsController.swift
//  iMovieTracker
//
//  Created by Niels Evenblij on 02/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = movie?.title
        //todo: add image
        //todo: add buttons
    }
    
    func addToWatchlist() {
        
    }
    
    func deleteFromWatchlist() {
        
    }
}
