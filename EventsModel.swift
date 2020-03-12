//
//  EventsModel.swift
//  EnginnerApp
//
//  Created by majkel on 07.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import UIKit
class EventModel {
    var idAuthor : Int
    var publishDate : Date
    var idEvent : Int
    var type : String
    var data : TopicModel
    var data2 : CircleModel
    init(idAuthor: Int , publishDate: Date , userId: Int , idEvent: Int, type: String , data: TopicModel,data2: CircleModel) {
        self.idAuthor = idAuthor
        self.publishDate = publishDate
        self.idEvent = idEvent
        self.type = type
        self.data = data
        self.data2 = data2
        
    }
}
