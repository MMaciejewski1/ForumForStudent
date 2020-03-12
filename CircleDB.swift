//
//  CircleDB.swift
//  EnginnerApp
//
//  Created by majkel on 03.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation
import Alamofire
import  SwiftyJSON

func circleLimit(howMany: String,date: Date, completion:  @escaping ([CircleModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dates = String(dateToTimestamp(date: date))
    let ind = dates.index(dates.endIndex,offsetBy: -2)
    let range = dates.startIndex ..< ind
    let dict = ["howMany": howMany ,"date":String(dates[range])!] as [String : Any]
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/circle/limit")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(header, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        var cc = [CircleModel]()
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala")
                return
            }
            let json = JSON(data:data!)
           let name = json["data"]
           
            let inu = (name.count) as Int
            for i in 0..<inu {
                
                let desc = name[i]["description"].string
                
                let  countSubbed = name[i]["countSubbed"].int!
                let userId = name[i]["userIdUser"].int!
                let auth = name[i]["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  nameT = name[i]["name"].string!
                let  isSubbed = name[i]["isSub"].int!
                let uuid = 1
                let  publishDate = timestampToDate(timestamp: name[i]["publishDate"].double!)
                let idCircle = name[i]["idCircle"].int!
                let countTopic = name[i]["countTopic"].int!
          
                let circle = CircleModel(description: desc!,countSubbed: countSubbed,userId: userId,author: author,name: nameT,isSubbed: isSubbed,uuid: uuid,publishDate: publishDate,idCircle: idCircle,countTopic: countTopic)
                cc.append(circle)
            }
             completion(cc)
           
           
        }
        task.resume()
    }
   
}

func oneCircle(id:String, completion:  @escaping ([CircleModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dict = ["id" : id]
    var cc = [CircleModel]()
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/circle/one")!
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
                
                let desc = name[i]["description"].string
                
                let  countSubbed = name[i]["countSubbed"].int!
                let userId = name[i]["userIdUser"].int!
                let auth = name[i]["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  nameT = name[i]["name"].string!
                let  isSubbed = name[i]["isSub"].int!
                let uuid = 1
                let  publishDate = timestampToDate(timestamp: name[i]["publishDate"].double!)
                let idCircle = name[i]["idCircle"].int!
                let countTopic = name[i]["countTopic"].int!
                
                let circle = CircleModel(description: desc!,countSubbed: countSubbed,userId: userId,author: author,name: nameT,isSubbed: isSubbed,uuid: uuid,publishDate: publishDate,idCircle: idCircle,countTopic: countTopic)
                cc.append(circle)
            }
            completion(cc)
        }
        task.resume()
    }
    
}

func searchCircle(howMany:String,name : String , description : String, completion:  @escaping ([CircleModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
     var cc = [CircleModel]()
    let dict = ["howMany" : howMany, "name" : name,"description" : description]
    
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/circle/search")!
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
                
                let desc = name[i]["description"].string
                
                let  countSubbed = name[i]["countSubbed"].int!
                let userId = name[i]["userIdUser"].int!
                let auth = name[i]["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  nameT = name[i]["name"].string!
                let  isSubbed = name[i]["isSub"].int!
                let uuid = 1
                let  publishDate = timestampToDate(timestamp: name[i]["publishDate"].double!)
                let idCircle = name[i]["idCircle"].int!
                let countTopic = name[i]["countTopic"].int!
                
                let circle = CircleModel(description: desc!,countSubbed: countSubbed,userId: userId,author: author,name: nameT,isSubbed: isSubbed,uuid: uuid,publishDate: publishDate,idCircle: idCircle,countTopic: countTopic)
                cc.append(circle)
            }
            completion(cc)
        }
        task.resume()
    }
   
}


func addCircle(name: String,description: String, completion:  @escaping ([CircleModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dict = ["name": name ,"description": description,"uuid":UUID().uuidString]
     var cc = [CircleModel]()
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/circle/add")!
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
         
            
                
                let desc = name["description"].string
                
                let  countSubbed = name["countSubbed"].int!
                let userId = name["userIdUser"].int!
                let auth = name["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  nameT = name["name"].string!
                let  isSubbed = name["isSub"].int!
                let uuid = 1
                let  publishDate = Date()
                let idCircle = name["idCircle"].int!
                let countTopic = name["countTopic"].int!
                
                let circle = CircleModel(description: desc!,countSubbed: countSubbed,userId: userId,author: author,name: nameT,isSubbed: isSubbed,uuid: uuid,publishDate: publishDate,idCircle: idCircle,countTopic: countTopic)
                cc.append(circle)
            
            completion(cc)

            
                  }
        task.resume()
    }
 
}
func subCircle(id: String,status: Bool) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dict = ["id": id ,"status": status] as [String : Any]
    
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/circle/sub")!
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
          
            
        }
        task.resume()
    }
    
}
func subCircleList(completion:  @escaping ([CircleModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dict = ["id": "" ,"status": ""]
     var cc = [CircleModel]()
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/circle/subCircle")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(header, forHTTPHeaderField: "Authorization")
    //    request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala")
                return
            }
            let json = JSON(data:data!)
            let name = json["data"]
     
            let inu = (name.count) as Int
            for i in 0..<inu {
                
                let desc = name[i]["description"].string
                
                let  countSubbed = name[i]["countSubbed"].int!
                let userId = name[i]["userIdUser"].int!
                let auth = name[i]["author"]
                let author =  UserModel(avatar: auth["avatar"].string! , email: auth["email"].string! , idUser: auth["idUser"].int! , lastName: auth["lastName"].string!,name : auth["name"].string!)
                let  nameT = name[i]["name"].string!
                let  isSubbed = name[i]["isSub"].int!
                let uuid = 1
                let  publishDate = timestampToDate(timestamp: name[i]["publishDate"].double!)
                let idCircle = name[i]["idCircle"].int!
                let countTopic = name[i]["countTopic"].int!
                let circle = CircleModel(description: desc!,countSubbed: countSubbed,userId: userId,author: author,name: nameT,isSubbed: isSubbed,uuid: uuid,publishDate: publishDate,idCircle: idCircle,countTopic: countTopic)
                cc.append(circle)
            }
            completion(cc)
        }
        task.resume()
    }
    
}

