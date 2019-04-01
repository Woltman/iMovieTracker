//
//  ViewController.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var movies = [Movie]()
    var baseImageUrl = "https://image.tmdb.org/t/p/w300"
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //startup loading animation
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
        
        //make sure there are no lines in screen from table
        self.tableView.separatorStyle = .none
        
        //load movielist
        let theMovieDB = TheMovieDB()
        theMovieDB.discoverMovies(callback: setMovies)
    }
    
    func setMovies(movies: [Movie]){
        self.movies = movies
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        cell.textLabel?.text = movies[indexPath.row].title
        
        let url = URL(string: "\(baseImageUrl)\(movies[indexPath.row].imageUrl)")
        if let data = try? Data(contentsOf: url!){
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }
}

