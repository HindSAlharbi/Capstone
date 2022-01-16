//
//  Thought.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/6/22.
//

import Foundation
import Firebase

class Thought{
    
    // Variables
    private(set) var userN: String!
    private(set) var TxtThought: String!
    private(set) var numLikes: Int!
    private(set) var numComments: Int!
    private(set) var timestamp: Date!
    private(set) var documentId: String!
    
    
    init(userN: String, TxtThought: String, numLikes: Int,numComments: Int, timestamp: Date,documentId: String ){
        self.userN = userN
        self.TxtThought = TxtThought
        self.numLikes = numLikes
        self.numComments = numComments
        self.timestamp = timestamp
        self.documentId = documentId
        
    }

class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
    var thoughts = [Thought]()
    
    guard let snap = snapshot else { return thoughts }
    for document in snap.documents {
        let data = document.data()
        
        let userN = data["userN"] as? String ?? "Anonymous"
        let TxtThought = data["TxtThought"] as? String ?? ""
        let numLikes = data["numLikes"] as? Int ?? 0
        let numComments = data["numComments"] as? Int ?? 0
        let documentId = document.documentID
        let savedDate = data ["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        let timestamp = savedDate.dateValue()
        
       
        let newThought = Thought(userN: userN, TxtThought: TxtThought, numLikes: numLikes, numComments: numComments, timestamp: timestamp, documentId: documentId)
        thoughts.append(newThought)
    }
    
    return thoughts
}
}
