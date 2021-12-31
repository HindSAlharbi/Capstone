//
//  CellTableViewCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/19/21.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTable: UIImageView!
    @IBOutlet weak var titlelable: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var numLike: UILabel!
    @IBOutlet weak var timestapLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       imageTable.layer.cornerRadius = 12

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(subject: SubjectList){
        
    }
    
    
}
