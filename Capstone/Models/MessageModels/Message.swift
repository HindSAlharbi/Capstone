//
//  Message.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/20/21.
//

import Foundation
import UIKit

class Message {
    
    var text: String?
    var sender: UIButton?
    var firstName: String?
    
}
extension Message {
    
    static func getMessage(dict: [String: Any]) -> Message {
       
        let massage = Message()
        
       
       massage.text = dict["text"] as? String
       massage.firstName = dict["firstName"] as? String
        
        return massage
    }
    static func createMessage(firstName:String,text: String) -> [String: Any] {
       
        let newMessage = [
            "text" : text , "firstName": firstName
                    ] as [String : Any]
        
        return newMessage
    }
    static func deletMessage(firstName: String,text: String) -> [String: Any] {
    
        
        let deletMessage = ["firstName": firstName, "text": text] as [String : Any]
            
            return deletMessage
        
        
    }
}
