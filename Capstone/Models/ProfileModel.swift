//
//  ProfileModel.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/14/21.
//

import Foundation
import UIKit

class ProfileModel {
    
var firstName:String?
var email: String?
var lastName: String?
    

}
extension ProfileModel {

static func getUser(dict: [String: Any]) -> ProfileModel {
   
    let profile = ProfileModel()
    
   
    profile.firstName = dict["first Name"] as? String
    profile.email = dict["email"] as? String
    profile.lastName = dict["last Name"] as? String
   
    return profile
}
    static func CreateUser(firstName:String,lastName: String,email:String) -> [String: Any] {
   
    let newUser = [
                   "last name":firstName,
                   "email" :email, "last Name": lastName
                ] as [String : Any]
    
    return newUser
}
}
