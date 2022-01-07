//
//  IdeasTableViewCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/6/22.
//

import UIKit

class IdeasTableViewCell: UITableViewCell {
    // outlet
    @IBOutlet weak var usLabel: UILabel!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likesNumlbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(thought: Thought){
        usLabel.text = thought.userN
        txtLbl.text = thought.TxtThought
    }
}
