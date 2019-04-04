//
//  Movie.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 01/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    var title: String
    var imageUrl: String
    var summary: String
    var image: UIImage
    var releaseDate: String
    
    init(){
        if let i = UIImage(named: "placeholder") {
            image = i
        }
        else {
            image = UIImage()
        }
        title = ""
        imageUrl = ""
        summary = ""
        releaseDate = ""
    }
    
    init(movie: CodableMovie){
        if let i = UIImage(named: "placeholder") {
            image = i
        }
        else {
            image = UIImage()
        }
        title = movie.title
        imageUrl = movie.imageUrl
        summary = movie.summary
        releaseDate = movie.releaseDate
    }
}
