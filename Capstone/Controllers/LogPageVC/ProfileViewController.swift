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
    
    @IBOutlet weak var firstNameProfile: UITextField!
    
    @IBOutlet weak var lastNameProfile: UITextField!

    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
print(db)
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.user = user
            self.emailtextfiled.text = user.email
            self.firstNameProfile.text = user.firstName
            self.lastNameProfile.text = user.lastName
        }
        
        if Auth.auth().currentUser?.uid == nil {
        }else{
        }
    }

    func update() {
        guard let user = user else { return  }
        
        UserApi.updateUserInfo(currentUser: user, uid: Auth.auth().currentUser?.uid ?? "", firstName: firstNameProfile.text ?? "", lastName: lastNameProfile.text ?? "")
    }
    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
       
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logOut", sender: nil)
           
        } catch let sigOutError as NSError {
            print("Error signing out : %@", sigOutError)
        }
    }
    
    
    @IBAction func editProfileBtn(_ sender: Any) {
        update()
    }
    
    
}

// navigationController?.popToRootViewController(animated: true)


