//
//  CommentTableViewCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/8/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var userCommentTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(comment:Comment){
        nameLbl.text = comment.userN
        userCommentTxt.text = comment.commentTxt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        dataLabel.text = timestamp
    }

}

