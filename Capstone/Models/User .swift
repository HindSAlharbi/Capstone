//
//  User .swift
//  Capstone
//
//  Created by Hind Alharbi on 12/13/21.
//

import Foundation
import UIKit

class User {
    
    var email: String?
    var firstName: String?
    var lastName: String?
}
extension User {
    
    static func getUser(dict: [String: Any]) -> User {
       
        let user = User()
        
       
        user.email = dict["email"] as? String
        user.firstName = dict["firstName"] as? String
        user.lastName = dict["lastName"] as? String
       
        return user
    }
    static func CreateUser(email:String,firstName: String, lastName: String ) -> [String: Any] {
       
        let newUser = [
                       "email" :email, "firstName": firstName, "lastName": lastName
                    ] as [String : Any]
        
        return newUser
    }
    static func update(firstName: String,lastName: String) -> [String: Any] {
    
        
            let newUser = ["firstName": firstName, "lastName": lastName] as [String : Any]
            
            return newUser
        
        
    }
}
