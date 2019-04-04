//
//  Setting.swift
//  
//
//  Created by Niels Evenblij on 03/04/2019.
//

import Foundation

class Setting {
    var key: String = ""
    var title: String = ""
    var value: Bool = false
    
    init(key:String, title:String, value:Bool){
        self.key = key
        self.title = title
        self.value = value
    }
}
