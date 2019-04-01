//
//  ViewController.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var series = ["bla1", "bla2", "bla3"]
    var movies = [Movie]()
    var baseImageUrl = "https://image.tmdb.org/t/p/w300"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=08989a42239e5b70c6e742a879cc531d"){
            let task = URLSession.shared.dataTask(with: url){ data, response, error in
                if let receivedData = data {
                    Swift.print("\(receivedData)")
                    
                    do {
                        // Optie 1: Gebruik JSONSerialization
                        
                        if let json = try JSONSerialization.jsonObject(with: receivedData) as? [String:Any] {
                            //Swift.print("\(json)")
                            if let movies = json["results"] as? [Any] {
                                //Swift.print("\(movies)")
                                for movie in movies{
                                    //Swift.print(movie)
                                    if var movie = movie as? [String:Any] {
                                        Swift.print(movie)
                                        var m: Movie
                                        m = Movie()
                                        m.title = movie["original_title"] as! String
                                        m.imageUrl = movie["poster_path"] as! String
                                        self.movies.append(m)
                                    }
                                }
                                DispatchQueue.main.async{
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    } catch { }
                }
                
            }
            
            task.resume()
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

