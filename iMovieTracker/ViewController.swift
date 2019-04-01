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
                                    Swift.print(movie)
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
        return series.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie", for: indexPath)
        
        cell.textLabel?.text = series[indexPath.row]
        
        return cell
    }
}

