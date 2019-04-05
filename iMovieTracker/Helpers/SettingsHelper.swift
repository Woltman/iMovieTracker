//
//  SettingsHelper.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 05/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import Foundation
import UIKit

class SettingsHelper {
    static func hideMoviePoster(movies: [Movie], indexPath: IndexPath, hide: Bool) -> UIImage? {
        if (!hide) {
            return movies[indexPath.row].image
        }
        else {
            return nil
        }
    }
    
    static func hideSubtitle(movies: [Movie], indexPath: IndexPath, hide: Bool) -> String {
        if(!hide){
            return movies[indexPath.row].releaseDate
        }
        else{
            return ""
        }
    }
}
