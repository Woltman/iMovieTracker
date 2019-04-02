//
//  TheMovieDB.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import Foundation

class TheMovieDB {
    let baseImageUrl = "https://image.tmdb.org/t/p/w300"
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "08989a42239e5b70c6e742a879cc531d"
    
    func discoverMovies(page: Int, callback: @escaping ([Movie]) -> Void) {
        var moviesResult = [Movie]()
        
        if let url = URL(string: "\(baseUrl)/discover/movie?api_key=\(apiKey)&page=\(page)"){
            let task = URLSession.shared.dataTask(with: url){ data, response, error in
                if let receivedData = data {
                    Swift.print("\(receivedData)")
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: receivedData) as? [String:Any] {
                            if let movies = json["results"] as? [Any] {
                                for movie in movies{
                                    if var movie = movie as? [String:Any] {
                                        Swift.print(movie)
                                        
                                        var m = Movie()
                                        m.title = movie["original_title"] as! String
                                        m.imageUrl = movie["poster_path"] as! String
                                        m.summary = movie["overview"] as! String
                                        moviesResult.append(m)
                                    }
                                }
                            }
                        }
                        callback(moviesResult)
                    } catch { }
                    
                }
            }
            task.resume()
            
        }
    }
    
    func loadImageData(url: String) -> Data{
        let url = URL(string: "\(baseImageUrl)\(url)")
        if let data = try? Data(contentsOf: url!){
            return data
        }
        return Data()
    }
}
