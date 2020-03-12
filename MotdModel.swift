//
//  MotdModel.swift
//  EnginnerApp
//
//  Created by majkel on 07.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
class MotdModel {
    var timestamp : Date
    var message : String
    var idMotd : Int
    var author : UserModel
    
    init(timestamp: Date , message: String , idMotd: Int , author: UserModel) {
        self.timestamp = timestamp
        self.message = message
        self.idMotd = idMotd
        self.author = author
        
        
    }
}
