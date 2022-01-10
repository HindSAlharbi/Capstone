//
//  SubjectList.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/15/21.
//

import Foundation
import UIKit
import Firebase

class SubjectList{


private(set) var subjectTitle: String!
private(set) var maintimestamp: Date!
private(set) var numComment: Int!
private(set) var numLike: Int!
private(set) var documentId: String!

    

    
    init(subjectTitle: String, numComment: Int, numLike: Int, documentId: String,maintimestamp: Date) {
        
        self.subjectTitle = subjectTitle
        self.maintimestamp = maintimestamp
        self.numComment = numComment
        self.numLike = numLike
        self.documentId = documentId
        
    }
//    
//    class func parseData(snapshot: QuerySnapshot?) -> [SubjectList] {
//        var mainSubjects = [SubjectList]()
//
//        guard let snap = snapshot else { return mainSubjects }
//        for document in snap.documents {
//            let data = document.data()
//
//            let subjectTitle = data["subjectTitle"] as? String ?? ""
//            //let maintimestamp = data["maintimestamp"] as? Date ?? Date()
//            let numComment = data["numComment"] as? Int ?? 0
//            let numLike = data["numLike"] as? Int ?? 0
//            let documentId = document.documentID
//            let maintimestamp = data["maintimestamp"] as? Date ?? Date()
//            let newTitle = SubjectList(subjectTitle: subjectTitle, numComment: numComment, numLike: numLike, documentId: documentId, maintimestamp: maintimestamp)
//            mainSubjects.append(newTitle)
//
//        }
//
//        return mainSubjects
//    }
}

struct SecondVCDetiels {
    let title: String
    let imageDetiels: UIImage
    let subTitle: String
    let titleDetiels: String
}

//struct SubjectList{
//
//let subjectTitle: String!
//let maintimestamp: Date!
//let numComment:Int!
//let numLike:Int!
//}
