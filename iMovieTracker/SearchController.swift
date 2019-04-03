//
//  SearchController.swift
//  iMovieTracker
//
//  Created by Niels Evenblij on 02/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    var activityIndicatorView: UIActivityIndicatorView!
    var movies = [Movie]()
    var page = 1
    var totalpages = 1
    var theMovieDB = TheMovieDB()
    
    var lastQuery = ""
    var isLoadingMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //startup loading animation
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.tableView.backgroundView = activityIndicatorView
        
        //make sure there are no lines in screen from table
        self.tableView.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
            let destination = segue.destination as? DetailsController {
            destination.movie = movies[selectedIndexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        cell.textLabel?.text = movies[indexPath.row].title
        cell.imageView?.image = movies[indexPath.row].image
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async{
            //setup loading screen
            self.movies = []
            self.tableView.separatorStyle = .none
            self.tableView.reloadData()
            self.activityIndicatorView.startAnimating()
            self.lastQuery = searchBar.text!
            
            self.theMovieDB.searchMovies(page: self.page, query: searchBar.text!, callback: self.setMovies)
        }
    }
    
    func setMovies(movies: [Movie], totalpages: Int){
        self.totalpages = totalpages
        self.movies = movies
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
    }
    
    func addMovies(movies: [Movie], totalpages: Int){
        self.movies.append(contentsOf: movies)
        self.isLoadingMovies = false
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) && !isLoadingMovies && page < totalpages) {
            activityIndicatorView.startAnimating()
            isLoadingMovies = true
            page+=1
            DispatchQueue.main.async {
                self.theMovieDB.searchMovies(page: self.page, query: self.lastQuery, callback: self.addMovies)
            }
        }
    }
}


