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
    static var watchlistMovies = [CodableMovie]()
    static var didChange = false
    static var theMovieDB = TheMovieDB()
    
    static func saveMovie(movie: Movie){
        if contains(movie: movie) {
            return
        }
        didChange = true
        let cMovie = CodableMovie(movie: movie)
        
        watchlistMovies.append(cMovie)
        Storage.store(watchlistMovies, to: .documents, as: "watchlist.json")
    }
    
    static func removeMovie(movie: Movie){
        for (index, m) in watchlistMovies.enumerated() {
            if m.title == movie.title {
                watchlistMovies.remove(at: index)
                didChange = true
                break
            }
        }
        
        Storage.store(watchlistMovies, to: .documents, as: "watchlist.json")
    }
    
    static func loadMovies() {
        if !(Storage.fileExists("watchlist.json", in: .documents)) {
            return
        }
        
        let cMovies = Storage.retrieve("watchlist.json", from: .documents, as: [CodableMovie].self)
        watchlistMovies.append(contentsOf: cMovies)
    }
    
    static func getMovies() -> [Movie] {
        didChange = false
        var result = [Movie]()

        for m in watchlistMovies {
            var movie = Movie()
            movie.imageUrl = m.imageUrl
            movie.title = m.title
            movie.summary = m.summary
            if let image = UIImage(data: theMovieDB.loadImageData(url: m.imageUrl)) {
                movie.image = image
            }
            result.append(movie)
        }
        return result
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
}
