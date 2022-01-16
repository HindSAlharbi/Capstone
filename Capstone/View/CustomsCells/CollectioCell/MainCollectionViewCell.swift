//
//  CellCollectionViewCell.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/19/21.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    // cell outlets
    @IBOutlet weak var imagePro: UIImageView!
    @IBOutlet weak var lableCollection: UILabel!
    
    override func awakeFromNib() {
        
        imagePro.layer.cornerRadius = 12

        
    }
}

