//
//  Setting.swift
//  
//
//  Created by Niels Evenblij on 03/04/2019.
//

import Foundation

class Setting {
    var setting: String = ""
    var title: String = ""
    var value: Bool = false
    
    init(setting:String, title:String, value:Bool){
        self.setting = setting
        self.title = title
        self.value = value
    }
}
