//
//  MoviesController.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class MoviesController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies = [Movie]()
    var activityIndicatorView: UIActivityIndicatorView!
    let theMovieDB = TheMovieDB()
    var page = 1
    var totalpages = 1;
    
    var searchData = [Movie]()
    var isSearching = false
    var isLoadingMovies = false
    
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
        DispatchQueue.main.async {
            self.theMovieDB.discoverMovies(page: self.page, callback: self.setMovies)
        }
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
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
        isLoadingMovies = false
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isSearching) {
            return searchData.count
        }
        
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        if (isSearching) {
            cell.textLabel?.text = searchData[indexPath.row].title
            cell.imageView?.image = searchData[indexPath.row].image
        }
        else {
            cell.textLabel?.text = movies[indexPath.row].title
            cell.imageView?.image = movies[indexPath.row].image
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if (searchBar.text == nil || searchBar.text == ""){
            isSearching = false;
            
            view.endEditing(true)
            
            tableView.reloadData()
        }
        else {
            isSearching = true
            
            searchData = movies.filter({$0.title.lowercased().contains(searchBar.text!.lowercased())})
            
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
            let destination = segue.destination as? DetailsController {
            if isSearching {
                destination.movie = searchData[selectedIndexPath.row]
            }
            else {
                destination.movie = movies[selectedIndexPath.row]
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) && !isLoadingMovies && page < totalpages) {
            activityIndicatorView.startAnimating()
            isLoadingMovies = true
            page+=1
            DispatchQueue.main.async {
                self.theMovieDB.discoverMovies(page: self.page, callback: self.addMovies)
            }
        }
    }
}

