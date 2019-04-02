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
        title = movie?.title
        summary.text = movie?.summary
        
        moviePoster.image = UIImage(data: theMovieDB.loadImageData(url: movie!.imageUrl)) 
        //todo: add buttons
    }
    
    @IBAction func deleteFromWatchList(_ sender: Any) {
        Swift.print("delete from list")
    }
    
    @IBAction func addToWatchList(_ sender: Any) {
        Swift.print("add to list")
    }
}
