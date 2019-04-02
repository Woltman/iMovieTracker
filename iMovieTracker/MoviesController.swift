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
    var baseImageUrl = "https://image.tmdb.org/t/p/w300"
    var activityIndicatorView: UIActivityIndicatorView!
    
    var searchData = [Movie]()
    var isSearching = false
    
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
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
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
        
        if (isSearching) {
            return searchData.count
        }
        
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        if (isSearching) {
            cell.textLabel?.text = searchData[indexPath.row].title
            
            let url = URL(string: "\(baseImageUrl)\(searchData[indexPath.row].imageUrl)")
            if let data = try? Data(contentsOf: url!){
                cell.imageView?.image = UIImage(data: data)
            }
        }
        else {
            cell.textLabel?.text = movies[indexPath.row].title
            
            let url = URL(string: "\(baseImageUrl)\(movies[indexPath.row].imageUrl)")
            if let data = try? Data(contentsOf: url!){
                cell.imageView?.image = UIImage(data: data)
            }
            
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
            destination.movie = movies[selectedIndexPath.row]
        }
    }
}

