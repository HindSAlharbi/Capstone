////
////  MessageApI.swift
////  Capstone
////
////  Created by Hind Alharbi on 12/20/21.
////
//
//import Foundation
//import FirebaseFirestore
//import Firebase
//import UIKit
//
//class MessageApI {
//    
//    static func addMessage(uid:String,firstName:String,body: String,sender: String , completion: @escaping (Bool) -> Void) {
//        
//        let refMessage = Firestore.firestore().collection("Message")
//        refMessage.document(uid).setData(Message.createMessage(firstName: firstName, body: body ,  sender: sender))
//    
//        completion(true)
//    }
//
//    static func getMessage(uid:String,completion: @escaping (Message) -> Void) {
//
//        let refUsers = Firestore.firestore().collection("Message")
//
//        refUsers.document(uid).getDocument { document, error in
//            if let document = document, document.exists {
//                let mess = Message.getMessage(dict: document.data()!)
//                completion(mess)
//            }
//        }
//
//    }
//    
//}
//
//
////    static func updateUserInfo(currentUser:User,uid:String,firstName:String,lastName: String) {
////
////        var first = ""
////        var last = ""
////
////        if firstName == currentUser.firstName {
////            first = currentUser.firstName ?? ""
////        } else {
////            first = firstName
////        }
////        if lastName == currentUser.lastName {
////            last = currentUser.lastName ?? ""
////        } else {
////            last = lastName
////        }
////
////
////        let refUsers = Firestore.firestore().collection("Message")
////        refUsers.document(uid).setData(User.update( firstName: first, lastName: last),merge: true)
////
////        }
