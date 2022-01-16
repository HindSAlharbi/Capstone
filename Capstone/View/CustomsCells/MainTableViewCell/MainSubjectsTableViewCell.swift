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
    
    //cell outlets
    @IBOutlet weak var imageTable: UIImageView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var numLike: UILabel!
    @IBOutlet weak var timestapLable: UILabel!
    
    // variable
    private var mainSubject: SubjectList!

    override func awakeFromNib() {
        super.awakeFromNib()
       imageTable.layer.cornerRadius = 12
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true

    }
    @objc func likeTapped() {
        Firestore.firestore().document("mainSubjects/\(mainSubject.documentId!)")
        .updateData(["numLike" : mainSubject.numLike + 1])
    }
    
    // Cell
    func configureCell(subjectList: SubjectList){
    if (Auth.auth().currentUser != nil) {
    self.mainSubject = subjectList
    numLike.text = String(subjectList.numComment)
    titlelable.text = subjectList.subjectTitle
    numLike.text = String(subjectList.numLike)

    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, hh:mm"
    let formattedDate = formatter.string(from: subjectList.maintimestamp)
    timestapLable.text = formattedDate
        }
    }
}






 

