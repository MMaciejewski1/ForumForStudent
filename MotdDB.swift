//
//  MotdDB.swift
//  EnginnerApp
//
//  Created by majkel on 07.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation
import SwiftyJSON
func motd(completion:  @escaping ([MotdModel])->Void) {
    let cred = "0936335f-9c03-4353-af7e-73f91bf6cc50:1111".data(using: String.Encoding.utf8)!
    let base64Cred = cred.base64EncodedString()
    let header = "Basic \(base64Cred)"
    let dict = ["howMany": "" ,"id":"90","date": ""]
    var cc = [MotdModel]()
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://37.233.102.142:8080/api/motd")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(header, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala")
                return
            }
            let json = JSON(data:data!)
            let name = json["data"]
            let inu = (name.count) as Int
            for i in 0..<inu {
                

                var author : UserModel?
                let auth = name[i]["author"]
                if auth != JSON.null {
                    var avatar : String?
                    var email : String?
                    var name : String?
                    var lastName : String?
                    
                    
                    if auth["avatar"] != JSON.null {  avatar = auth["avatar"].string!}
                    else {avatar = "f"}
                    if auth["email"] != JSON.null {      email = auth["email"].string!} else { email = "d"}
                    let idUser = auth["idUser"].int!
                    if auth["lastName"] != JSON.null {      lastName = auth["lastName"].string!} else {lastName = "d"}
                    if auth["lastName"] != JSON.null {         name = auth["name"].string!} else { name = "d"}
                    
                    
                    
                    
                    
                    
                author =  UserModel(avatar: avatar!, email: email! , idUser: idUser , lastName: lastName!,name : name!)
                    }
                else {
                    author =  UserModel(avatar: "d" , email:"d" , idUser: 0 , lastName: "d",name : "d")
                }

                
                let  message = name[i]["message"].string!

                let  publishDate = NSDate()
                let idMotd = name[i]["idMotd"].int!

                
                let circle = MotdModel(timestamp: publishDate as Date , message: message , idMotd: idMotd , author: author!)
                cc.append(circle)
            }
            completion(cc)
        }
        task.resume()
    }
    
}
