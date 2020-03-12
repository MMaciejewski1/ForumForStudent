//
//  TopicModel.swift
//  EnginnerApp
//
//  Created by majkel on 05.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
class TopicModel {
    var description : String
    var countSubbed : Int
    var userId : Int
    var uuid : Int
    var name : String
    var author : UserModel
    var isSubbed : Int
    var publishDate : Date
    var idCircle : Int
    var countAnswer : Int
    var idTopic : Int
    
    init(description: String , countSubbed: Int , userId: Int , author: UserModel,name : String,isSubbed: Int , uuid: Int , publishDate: Date,idCircle : Int,countAnswer : Int,idTopic : Int) {
        self.description = description
        self.countSubbed = countSubbed
        self.userId = userId
        self.uuid = uuid
        self.name = name
        self.author = author
        self.isSubbed = isSubbed
        self.publishDate = publishDate
        self.idCircle = idCircle
        self.countAnswer = countAnswer
        self.idTopic = idTopic
        
        
}
}
