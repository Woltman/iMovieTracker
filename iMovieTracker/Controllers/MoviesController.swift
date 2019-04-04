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
    
    var discoverMovies = [Movie]()
    var defaultStorage = DefaultStorage()
    var activityIndicatorView: UIActivityIndicatorView!
    let theMovieDB = TheMovieDB()
    var page = 1
    var totalpages = 1;
    var hideMoviePoster = false;
    
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
        
        //Get Hide Movie Poster setting
        hideMoviePoster = defaultStorage.getSetting(key: "hideMoviePoster")
        
        //load movielist
        DispatchQueue.main.async {
            self.theMovieDB.discoverMovies(page: self.page, callback: self.setMovies)
        }
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (hideMoviePoster != defaultStorage.getSetting(key: "hideMoviePoster")){
            hideMoviePoster = defaultStorage.getSetting(key: "hideMoviePoster")
            tableView.reloadData()
        }
    }
    
    func setMovies(movies: [Movie], totalpages: Int){
        self.totalpages = totalpages
        self.discoverMovies = movies
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
    }
    
    func addMovies(movies: [Movie], totalpages: Int){
        self.discoverMovies.append(contentsOf: movies)
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
        
        return discoverMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        if (isSearching) {
            cell.textLabel?.text = searchData[indexPath.row].title
            if (!hideMoviePoster) {
                cell.imageView?.image = searchData[indexPath.row].image
            }
            else {
                cell.imageView?.image = nil
            }
        }
        else {
            cell.textLabel?.text = discoverMovies[indexPath.row].title
            if (!hideMoviePoster) {
                cell.imageView?.image = discoverMovies[indexPath.row].image
            }
            else {
                cell.imageView?.image = nil
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
            
            if let query = searchBar.text?.lowercased(){
                searchData = discoverMovies.filter({$0.title.lowercased().contains(query.lowercased())})
            }
            
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
                destination.movie = discoverMovies[selectedIndexPath.row]
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

