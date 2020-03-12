//
//  LoginDB.swift
//  EnginnerApp
//
//  Created by majkel on 03.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation
import  SwiftyJSON

    func validatePin(token: String,pin: String, completion:  @escaping ([UserModel])->Void)    {
  
               let dict = ["token": token ,"pin":pin]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            var cc = [UserModel]()
            
            let url = NSURL(string: "http://37.233.102.142:8080/validatePin")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
            request.httpBody = jsonData
            
            
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print("nie dziala")
                return
            }
            let json = JSON(data:data!)
            let name = json["data"]
            let c = UserModel(avatar: name["avatar"].string!,email: name["email"].string!,idUser: name["idUser"].int!,lastName: name["name"].string!,name: name["lastName"].string!)
         
           cc.append(c)
            completion(cc)
        }
        task.resume()
}

        
    }

    func reg(token: String,pin: String) -> Bool {
        let dict = ["token": token , "pin": pin]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            
            
            let url = NSURL(string: "http://37.233.102.142:8080/registerrest")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                  //  print("\(json)\n\(token)\n\(pin)")
                    
                    if let parseJSON = json?["data"] as? NSDictionary{
                        let resultValue:String = parseJSON["name"] as! String
                  //      print("result: \(resultValue)")
                       
                    }
                } catch let error as NSError {
                    print(error)
                }        
            }          
            task.resume()
        }
        
        
        
        
        
        
    return true
    }
    
    

