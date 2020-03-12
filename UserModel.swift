//
//  UserModel.swift
//  EnginnerApp
//
//  Created by majkel on 05.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
class UserModel {
    var avatar : String
    var email : String
    var idUser : Int
    var lastName : String
    var name : String
    
    init(avatar: String , email: String , idUser: Int , lastName: String,name : String) {
        self.avatar = avatar
        self.email = email
        self.idUser = idUser
        self.lastName = lastName
        self.name = name
    }

}
