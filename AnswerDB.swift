//
//  AnswerDB.swift
//  EnginnerApp
//
//  Created by majkel on 05.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation
import  SwiftyJSON
func answerLimit(howMany: String,id:Int ,date: Date, completion:  @escaping ([AnswerModel])->Void)  {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dates = String(dateToTimestamp(date: date))
    let ind = dates.index(dates.endIndex,offsetBy: -2)
    let range = dates.startIndex ..< ind
    let dict = ["howMany": howMany ,"id":String(id),"date": dates[range]]
    var cc = [AnswerModel]()
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/answer/limitLess")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(header, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala")
                return
            }
            let json = JSON(data:data!)
            let name = json["data"]
         
            let inu = (name.count) as Int
            for i in 0..<inu {
                
                
                
                let  yours = name[i]["yours"].int!
                let userId = name[i]["userIdUser"].int!
                let auth = name[i]["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  content = name[i]["content"].string!
               let  publishDate = timestampToDate(timestamp: name[i]["publishDate"].double!)
                let uuid = 1
                let idTopic = 0
                
                let circle = AnswerModel(content: content , yours: yours , userId: userId , author: author, uuid: uuid , publishDate: publishDate,idTopic : idTopic)
                cc.append(circle)
            }
            completion(cc)
        }
        task.resume()
    }
 
}

func addAnswer(content: String,id:String, completion:  @escaping ([AnswerModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dict = ["content": content ,"id" : id,"uuid":UUID().uuidString]
    var cc = [AnswerModel]()
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/answer/add")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(header, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala")
                return
            }
        //    let json = JSON(data:data!)
            let json = JSON(data:data!)
            let name = json["data"]
                
                let  yours = name["yours"].int!
                let userId = name["userIdUser"].int!
                let auth = name["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  content = name["content"].string!
                let  publishDate = timestampToDate(timestamp: name["publishDate"].double!)
                let uuid = 1
                let idTopic = 0
                
                let circle = AnswerModel(content: content , yours: yours , userId: userId , author: author, uuid: uuid , publishDate: publishDate,idTopic : idTopic)
                cc.append(circle)
            
            completion(cc)
        
        }
        task.resume()
    }
   
}

