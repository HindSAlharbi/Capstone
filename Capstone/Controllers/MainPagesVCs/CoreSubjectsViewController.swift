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

class CoreSubjectsViewController: UIViewController {

    @IBOutlet weak var superTitleLabel: UILabel!
    @IBOutlet weak var superImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var coreTextLabel: UILabel!
    
    var secondDetias:SecondVCDetiels!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        superTitleLabel.text = ""
        superImage.image = UIImage(named: "")
        subTitleLabel.text = ""
        coreTextLabel.text = ""
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @IBAction func shareIdea(_ sender: Any) {
        
      performSegue(withIdentifier: "ideas", sender: nil)
        
    }
}
