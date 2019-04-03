//
//  TheMovieDB.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import Foundation
import UIKit

class TheMovieDB {
    let baseImageUrl = "https://image.tmdb.org/t/p/w300"
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "08989a42239e5b70c6e742a879cc531d"
    
    func discoverMovies(page: Int, callback: @escaping ([Movie], Int) -> Void) {
        var moviesResult = [Movie]()
        var totalpages = 1;
        
        if let url = URL(string: "\(baseUrl)/discover/movie?api_key=\(apiKey)&page=\(page)"){
            let task = URLSession.shared.dataTask(with: url){ data, response, error in
                if let receivedData = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: receivedData) as? [String:Any] {
                            Swift.print(json)
                            if let tpages = json["total_pages"] as? Int {
                                totalpages = tpages
                            }
                            
                            if let movies = json["results"] as? [Any] {
                                for movie in movies{
                                    if var movie = movie as? [String:Any] {
                                        var m = Movie()
                                        if let title = movie["original_title"] as? String{
                                            m.title = title
                                        }
                                        if let url = movie["poster_path"] as? String {
                                            m.imageUrl = url
                                            if let image = UIImage(data: self.loadImageData(url: m.imageUrl)) {
                                                m.image = image
                                            }
                                        }
                                        if let summary = movie["overview"] as? String {
                                            m.summary = summary
                                        }
                                        moviesResult.append(m)
                                    }
                                }
                            }
                        }
                        callback(moviesResult, totalpages)
                    } catch { }
                    
                }
            }
            task.resume()
            
        }
    }
    
    func searchMovies(page: Int, query: String, callback: @escaping ([Movie], Int) -> Void) {
        var moviesResult = [Movie]()
        var totalpages = 1;
        
        if let url = URL(string: "\(baseUrl)/search/movie?api_key=\(apiKey)&page=\(page)&query=\(query)"){
            let task = URLSession.shared.dataTask(with: url){ data, response, error in
                if let receivedData = data {
                    Swift.print("\(receivedData)")
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: receivedData) as? [String:Any] {
                            if let tpages = json["total_pages"] as? Int {
                                totalpages = tpages
                            }
                            if let movies = json["results"] as? [Any] {
                                for movie in movies{
                                    if var movie = movie as? [String:Any] {
                                        var m = Movie()
                                        if let title = movie["original_title"] as? String{
                                            m.title = title
                                        }
                                        if let url = movie["poster_path"] as? String {
                                            m.imageUrl = url
                                            if let image = UIImage(data: self.loadImageData(url: m.imageUrl)) {
                                                m.image = image
                                            }
                                        }
                                        if let summary = movie["overview"] as? String {
                                            m.summary = summary
                                        }
                                        moviesResult.append(m)
                                    }
                                }
                            }
                        }
                        callback(moviesResult, totalpages)
                    } catch { }
                    
                }
            }
            task.resume()
            
        }
    }
    
    func loadImageData(url: String) -> Data{
        if let url = URL(string: "\(baseImageUrl)\(url)") {
            if let data = try? Data(contentsOf: url){
                return data
            }
        }
        
        return Data()
    }
}
