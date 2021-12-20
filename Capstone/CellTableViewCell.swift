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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
