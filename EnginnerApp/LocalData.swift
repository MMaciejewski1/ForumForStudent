//
//  LocalData.swift
//  EnginnerApp
//
//  Created by majkel on 07.01.2018.
//  Copyright © 2018 majkel. All rights reserved.
//

import Foundation


func saveLD(token : String) {
UserDefaults.standard.set(token, forKey: "token")
}
func savePass(pass : String){
    UserDefaults.standard.set(pass, forKey: "pass")
}
func loadPass()->String{
return UserDefaults.standard.string(forKey: "pass")!
}
func deletePass(){
 UserDefaults.standard.removeObject(forKey: "pass")
}



func loadLD()->String{
    return  UserDefaults.standard.string(forKey: "token")!
   }
func checkLD()->Bool {
    
    if UserDefaults.standard.string(forKey: "token") != "" && UserDefaults.standard.string(forKey: "token") != nil
    {

    return true
    }
    else {
        
        return false
    }
}
func deleteLD(){

    UserDefaults.standard.removeObject(forKey: "token")

}
