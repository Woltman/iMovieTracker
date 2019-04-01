//
//  WatchlistController.swift
//  iMovieTracker
//
//  Created by Niels Evenblij on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class WatchlistController: UITableViewController {
    
    var watchlist = [Movie]()
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
    }
    
    func setWatchlist(watchlist: [Movie]){
        self.watchlist = watchlist
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        cell.textLabel?.text = watchlist[indexPath.row].title
        
        return cell
    }
}

