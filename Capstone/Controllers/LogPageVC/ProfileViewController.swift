//
//  ProfileViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/13/21.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var emailtextfiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.emailtextfiled.text = user.email
        }
        
        if Auth.auth().currentUser?.uid == nil {
        }else{
        }
    }


    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
       
        do {
            try Auth.auth().signOut()
            
        } catch let sigOutError as NSError {
            print("Error signing out : %@", sigOutError)
        }
    }
}




