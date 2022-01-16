//
//  MainSubjectsViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/3/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class SubjectdetailsVController: UIViewController {
    // Outlets
    @IBOutlet weak var superTitleLabel: UILabel!
    @IBOutlet weak var superImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var coreTextLabel: UILabel!
    // Varabiles
    var TitleLabel: String!
    var ImageTitle: UIImage!
    var subtitleLabel: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        superImage.layer.cornerRadius = 10
        superTitleLabel.text = TitleLabel
        superImage.image = ImageTitle
        coreTextLabel.text = subtitleLabel
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
