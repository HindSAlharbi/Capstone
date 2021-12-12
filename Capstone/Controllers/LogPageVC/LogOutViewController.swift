//
//  LogOutViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/11/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let sigOutError as NSError {
            print("Error signing out : %@", sigOutError)
        }
    }
    
}
