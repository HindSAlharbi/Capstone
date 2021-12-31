//
//  ReviewsCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/28/21.
//

import UIKit
import FirebaseAuth
import Firebase

class ReviewsCell: UITableViewCell {

    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var lableReview: UILabel!
    @IBOutlet weak var firstNameReviewLable: UILabel!
    
    var userMessage: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewView.layer.cornerRadius = reviewView.frame.size.height / 5
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
