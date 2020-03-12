//
//  EventsDB.swift
//  EnginnerApp
//
//  Created by majkel on 07.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation
import SwiftyJSON
func eventsTab(completion:  @escaping ([EventModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    var cc = [EventModel]()

        let url = NSURL(string: "http://37.233.102.142:8080/api/events")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(header, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala \(error?.localizedDescription)")
                return
            }
            let json = JSON(data:data!)
               let name = json["data"]
           
            let inu = (name.count) as Int
             for i in 0..<inu {
            
            
            //  if(json[i]["type"] == "Topic")
            //     {
           // print("dzieje sie ")
                if name[i]["type"] == "Topic" {
                    let desc = name[i]["data"]["description"].string
                    
                    let  countSubbed = name[i]["data"]["countSubbed"].int!
                    let userId = name[i]["data"]["userIdUser"].int!
                    let auth = name[i]["data"]["author"]
                    let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                    let  nameT = name[i]["data"]["name"].string!
                    let  isSubbed = name[i]["data"]["isSub"].int!
                    let uuid = 1
                    let  publishDate = timestampToDate(timestamp: name[i]["data"]["publishDate"].double!)
                    let idCircle = name[i]["data"]["circleIdCircle"].int!
                    let countTopic = name[i]["data"]["countAnswer"].int!
                    let idTopic = name[i]["data"]["idTopic"].int!
                    let data = TopicModel(description: desc! , countSubbed: countSubbed , userId: userId , author: author,name : nameT,isSubbed: isSubbed , uuid: uuid , publishDate: publishDate,idCircle : idCircle,countAnswer : countTopic,idTopic : idTopic)
                
                
                    let ccc = CircleModel(description: "",countSubbed: 0,userId: 0,author: author,name: "",isSubbed: 0,uuid: 0,publishDate: timestampToDate(timestamp: name[i]["data"]["publishDate"].double!),idCircle: 0,countTopic: 0)
                     let  type = name[i]["type"].string!
                    let circle = EventModel(idAuthor: author.idUser , publishDate: publishDate , userId: userId , idEvent: isSubbed, type: type , data: data,data2:ccc)
                    cc.append(circle)
                    }
                
                else {
                    
                    
                    let desc = name[i]["data"]["description"].string
                    
                    let  countSubbed = name[i]["data"]["countSubbed"].int!
                    let userId = name[i]["data"]["userIdUser"].int!
                    let auth = name[i]["data"]["author"]
                    let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                    let  nameT = name[i]["data"]["name"].string!
                    let  isSubbed = name[i]["data"]["isSub"].int!
                    let uuid = 1
                    let  publishDate = timestampToDate(timestamp: name[i]["data"]["publishDate"].double!)
                    let idCircle = name[i]["data"]["idCircle"].int!
                    let countTopic = name[i]["data"]["countTopic"].int!
                    
                    let data =  TopicModel(description:"", countSubbed: 0 , userId: 0, author: author,name : "",isSubbed: 0, uuid: 0 , publishDate: timestampToDate(timestamp: name[i]["data"]["publishDate"].double!),idCircle : 0,countAnswer : 0,idTopic : 0)
                    
                    let ccc = CircleModel(description: desc!,countSubbed: countSubbed,userId: userId,author: author,name: nameT,isSubbed: isSubbed,uuid: uuid,publishDate: publishDate,idCircle: idCircle,countTopic: countTopic)
                    let  type = name[i]["type"].string!
                    let circle = EventModel(idAuthor: author.idUser , publishDate: publishDate , userId: userId , idEvent: isSubbed, type: type , data: data,data2:ccc)
                    cc.append(circle)

                
                
                }
             }

            completion(cc)

        }
        task.resume()
    }
   

