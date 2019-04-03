//
//  DetailsController.swift
//  iMovieTracker
//
//  Created by Niels Evenblij on 02/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    var movie: Movie?
    var theMovieDB = TheMovieDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.title = self.movie?.title
            self.summary.text = self.movie?.summary
            self.moviePoster.image = self.movie?.image
        }
    }
    
    @IBAction func deleteFromWatchList(_ sender: Any) {
        Swift.print("delete from list")
    }
    
    @IBAction func addToWatchList(_ sender: Any) {
        Swift.print("add to list")
    }
}
