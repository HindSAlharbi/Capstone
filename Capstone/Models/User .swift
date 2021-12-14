//
//  User .swift
//  Capstone
//
//  Created by Hind Alharbi on 12/13/21.
//

import Foundation
import UIKit

class User {
    
    var name:String?
    var email: String?

}
extension User {
    
    static func getUser(dict: [String: Any]) -> User {
       
        let user = User()
        
       
        user.name = dict["name"] as? String
        user.email = dict["email"] as? String
       
        return user
    }
    static func CreateUser(name:String,email:String) -> [String: Any] {
       
        let newUser = [
                       "name":name,
                       "email" :email
                    ] as [String : Any]
        
        return newUser
    }
}
