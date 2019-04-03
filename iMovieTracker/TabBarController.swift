//
//  TabBarController.swift
//  iMovieTracker
//
//  Created by Thom Woltman on 03/04/2019.
//  Copyright © 2019 thomniels. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var selectedTab = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }
    
    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController is MoviesController {
            if selectedTab != 1 {
                print("Discover tab")
                selectedTab = 1
            }
        } else if viewController is SearchController {
            if selectedTab != 2 {
                print("Search tab")
                selectedTab = 2
            }
        } else if viewController is WatchlistController {
            if selectedTab != 3 {
                print("Watchlist tab")
                selectedTab = 3
                
                if let watchlistController = viewController as? WatchlistController {
                    watchlistController.updateWatchlist()
                }
            }
        }
    }
    
    
}
