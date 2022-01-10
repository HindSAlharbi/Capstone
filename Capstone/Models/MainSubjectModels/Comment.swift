//
//  Comment.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/8/22.
//

import Foundation
import Firebase

class Comment {
    
        private(set) var userN: String!
        private(set) var commentTxt: String!
        private(set) var  timestamp: Date!
        
        init(userN: String, commentTxt: String, timestamp: Date){
            self.userN = userN
            self.commentTxt = commentTxt
            self.timestamp = timestamp
        }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()

        guard let snap = snapshot else { return comments }
        for document in snap.documents {
            let data = document.data()
            let userN = data["userNe"] as? String ?? "Anonymous"
            let timestamp = data["timestamp"] as? Date ?? Date()
            let commentTxt = data["commentTxt"] as? String ?? ""

            let newComment = Comment(userN: userN, commentTxt: commentTxt, timestamp: timestamp)
            comments.append(newComment)
        }

        return comments
    }

    }

    
    
    
    
    
    




