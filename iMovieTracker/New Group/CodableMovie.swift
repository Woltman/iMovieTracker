//
//  CodableMovie.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 03/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import Foundation

class CodableMovie : Codable {
    var title: String = ""
    var imageUrl: String = ""
    var summary: String = ""
    
    init(movie: Movie) {
        title = movie.title
        imageUrl = movie.imageUrl
        summary = movie.summary
    }
}
