////
////  Message.swift
////  Capstone
////
////  Created by Hind Alharbi on 12/20/21.
////
//
//import Foundation
//import UIKit
//
//class Message {
//    
//    var body: String?
//    var sender: String?
//    var firstName: String?
//    
//}
//extension Message {
//    
//    static func getMessage(dict: [String: Any]) -> Message {
//       
//        let massage = Message()
//        
//       
//       massage.body = dict["text"] as? String
//       massage.firstName = dict["firstName"] as? String
//        massage.sender = dict["sender"] as? String
//        
//        return massage
//    }
//    static func createMessage(firstName:String,body: String,sender: String ) -> [String: Any] {
//       
//        let newMessage = [
//            "body" : body , "firstName": firstName,"sender": sender
//                    ] as [String : Any]
//        
//        return newMessage
//    }
//    static func deletMessage(firstName: String,body: String,sender: String) -> [String: Any] {
//    
//        
//        let deletMessage = ["firstName": firstName, "body": body , sender: "sender"] as [String : Any]
//            
//            return deletMessage
//        
//        
//    }
//}
//
//struct UserMessage{
//    let text: String
//    let sender: String
//}
