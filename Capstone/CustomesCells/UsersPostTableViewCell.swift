//
//  IdeasTableViewCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/6/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class UsersPostTableViewCell: UITableViewCell {
    // outlet
    @IBOutlet weak var usLabel: UILabel!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likesNumlbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var commentsNumLable: UILabel!
    
    private var thought: Thought!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeImage.addGestureRecognizer(tap)
        likeImage.isUserInteractionEnabled = true
        
    }
    @objc func likeTapped() {

        Firestore.firestore().document("thoughts/\(thought.documentId!)")
        .updateData(["numLikes" : thought.numLikes + 1])
    }

       // Configure the view for the selected state
    
    func configureCell(thought: Thought){
        self.thought = thought
        usLabel.text = thought.userN
        txtLbl.text = thought.TxtThought
        //commentsNumLable.text = String(thought.numComments)
        likesNumlbl.text = String(thought.numLikes)
        
        if let uid = Auth.auth().currentUser?.uid{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
            dataLbl.text = timestamp

        }
    }
    }

