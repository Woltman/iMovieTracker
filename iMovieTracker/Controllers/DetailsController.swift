//
//  DetailsController.swift
//  iMovieTracker
//
//  Created by Niels Evenblij on 02/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var deleteFromWatchListButton: UIButton!
    @IBOutlet weak var addToWatchListButton: UIButton!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    var movie: Movie?
    var theMovieDB = TheMovieDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.movie?.title
        self.summary.text = self.movie?.summary
        self.moviePoster.image = self.movie?.image
        
        if let m = self.movie {
            if WatchList.contains(movie: m) {
                addToWatchListButton.isEnabled = false
            }
            else {
                deleteFromWatchListButton.isEnabled = false
            }
        }
    }
    
    @IBAction func deleteFromWatchList(_ sender: Any) {
        Swift.print("delete from list")
        toggleEnabledButtons()
        if let movie = self.movie {
            DispatchQueue.main.async {
                WatchList.removeMovie(movie: movie)
            }
        }
    }
    
    @IBAction func addToWatchList(_ sender: Any) {
        Swift.print("add to list")
        toggleEnabledButtons()
        if let movie = self.movie {
            DispatchQueue.main.async {
                WatchList.saveMovie(movie: movie)
            }
        }
    }
    
    func toggleEnabledButtons() {
        addToWatchListButton.isEnabled = !addToWatchListButton.isEnabled
        deleteFromWatchListButton.isEnabled = !deleteFromWatchListButton.isEnabled
    }
}
