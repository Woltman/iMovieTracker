//
//  DefaultStorage.swift
//  
//
//  Created by Niels Evenblij on 04/04/2019.
//

import Foundation

class DefaultStorage {
    
    var defaults = UserDefaults.standard
    
    func getSetting(key: String) -> Bool {
        if (defaults.string(forKey: key) != nil) {
            return defaults.bool(forKey: key)
        }
        else{
            setSetting(key: key, value: false)
            return false
        }
    }
    
    func setSetting(key: String, value: Bool) {
        defaults.set(value, forKey: key)
    }
}
