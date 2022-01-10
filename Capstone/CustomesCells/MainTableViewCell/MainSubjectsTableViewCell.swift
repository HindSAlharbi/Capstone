//
//  CellTableViewCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/19/21.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class MainSubjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTable: UIImageView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var numLike: UILabel!
    @IBOutlet weak var timestapLable: UILabel!
    
    private var mainSubject: SubjectList!

    override func awakeFromNib() {
        super.awakeFromNib()
       imageTable.layer.cornerRadius = 12
//        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
//        //likesImage.addGestureRecognizer(tap)
//        likesImage.isUserInteractionEnabled = true
//        // Initialization code
    }

   
    @objc func likeTapped() {
        
//        Firestore.firestore().document("mainSubjects")
//            .updateData(["numLike" : mainSubject.numLike + 1])
    }
    func configureCell(subjectList: SubjectList){
    
    numLike.text = String(subjectList.numComment)
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, hh:mm"
    let timestamp = formatter.string(from: subjectList.maintimestamp)
    timestapLable.text = timestamp
    }
}







//        Firestore.firestore().collection("mainSubject").document(mainSubject.documentId)
//                   .setData(["numLike" : mainSubject.numLike + 1])
//        Firestore.firestore().document( "\(mainSubject!)")
//    .updateData(["numLike" : mainSubject.numLike + 1])
    
