//
//  WatchList.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 03/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import Foundation
import UIKit

class WatchList {
    static var watchlistMovies = [Movie]()
    static var didChange = false
    static var theMovieDB = TheMovieDB()
    
    static func saveMovie(movie: Movie){
        if contains(movie: movie) {
            return
        }
        didChange = true
        watchlistMovies.append(movie)
        
        let cMovies = parse(movies: watchlistMovies)
        Storage.store(cMovies, to: .documents, as: "watchlist.json")
    }
    
    static func removeMovie(movie: Movie){
        for (index, m) in watchlistMovies.enumerated() {
            if m.title == movie.title {
                watchlistMovies.remove(at: index)
                didChange = true
                break
            }
        }
        let cMovies = parse(movies: watchlistMovies)
        Storage.store(cMovies, to: .documents, as: "watchlist.json")
    }
    
    static func loadMovies() {
        if !(Storage.fileExists("watchlist.json", in: .documents)) {
            return
        }
        
        let cMovies = Storage.retrieve("watchlist.json", from: .documents, as: [CodableMovie].self)
        var movies = [Movie]()
        for m in cMovies {
            var movie = Movie(movie: m)
            let data = theMovieDB.loadImageData(url: m.imageUrl)
            if let image = UIImage(data: data) {
                movie.image = image
            }
            movies.append(movie)
        }
        watchlistMovies.append(contentsOf: movies)
    }
    
    static func getMovies() -> [Movie] {
        didChange = false
        return watchlistMovies
    }
    
    static func didListChange() -> Bool {
        return didChange
    }
    
    static func contains(movie: Movie) -> Bool {
        for m in watchlistMovies {
            if m.title == movie.title {
                return true
            }
        }
        return false
    }
    
    private static func parse(movies: [Movie]) -> [CodableMovie]{
        var result = [CodableMovie]()
        for m in movies {
            let cMovie = CodableMovie(movie: m)
            result.append(cMovie)
        }
        return result
    }
    
    private static func parse(cMovies: [CodableMovie]) -> [Movie]{
        var result = [Movie]()
        for m in cMovies {
            let movie = Movie(movie: m)
            result.append(movie)
        }
        return result
    }
}
