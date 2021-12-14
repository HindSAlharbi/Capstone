//
//  UserApi.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/13/21.
//

import Foundation
import FirebaseFirestore
import Firebase

class UserApi {
    
    static func addUser(name:String,uid:String,email:String,completion: @escaping (Bool) -> Void) {
        
        let refUsers = Firestore.firestore().collection("Users")
        
        
        refUsers.document(uid).setData(User.CreateUser(name: name, email: email))
        
        completion(true)
        
    }
    static func getUser(uid:String,completion: @escaping (User) -> Void) {

        let refUsers = Firestore.firestore().collection("Users")

        refUsers.document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let user = User.getUser(dict: document.data()!)
                completion(user)
            }
        }

    }
    
}
