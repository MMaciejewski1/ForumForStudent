//
//  AnswerModel.swift
//  EnginnerApp
//
//  Created by majkel on 05.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//



import UIKit
class AnswerModel {
    var content : String
    var yours : Int
    var userId : Int
    var uuid : Int
    var author : UserModel
    var publishDate : Date
    var idTopic : Int
    
    init(content: String , yours: Int , userId: Int , author: UserModel, uuid: Int , publishDate: Date,idTopic : Int) {
        self.content = content
        self.yours = yours
        self.userId = userId
        self.uuid = uuid
        self.author = author
        self.publishDate = publishDate
        self.idTopic = idTopic
        
        
    }
}
