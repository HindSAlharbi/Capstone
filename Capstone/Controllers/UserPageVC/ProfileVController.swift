//
//  ProfileViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/13/21.
//

import UIKit
import Photos
import FirebaseAuth
import Firebase
import FirebaseStorage

class ProfileVController: UITableViewController{
   
    //Outlets
    @IBOutlet weak var emailtextfiled: UITextField!
    @IBOutlet weak var firstNameProfile: UITextField!
    @IBOutlet weak var lastNameProfile: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tapToCahnePhoto:
    UIButton!
    
    // Variables
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom outlet
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.user = user
            self.emailtextfiled.text = user.email
            self.firstNameProfile.text = user.firstName
            self.lastNameProfile.text = user.lastName
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    func update() {
        guard let user = user else { return  }
        UserApi.updateUserInfo(currentUser: user, uid: Auth.auth().currentUser?.uid ?? "", firstName: firstNameProfile.text ?? "", lastName: lastNameProfile.text ?? "")
    }
    @IBAction func logOutBtn(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: Constants.logOut, sender: nil)

        } catch let sigOutError as NSError {
            print("Error signing out : %@", sigOutError)
        }
    }
    
    @IBAction func editProfileBtn(_ sender: Any) {
        update()
    }
    
    @IBAction func lightDarkMoodBtn(_ sender: Any) {
        if #available(iOS 15.0, *){
            let appDelegate = UIApplication.shared.windows.first
            if (sender as AnyObject).isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
            return
        }
    }
    @IBAction func languageBtn(_ sender: Any) {
        let alert = UIAlertController(title: "If you want to change the language go to the setting.".locatized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".locatized, style: .destructive, handler: nil))
        let settings = UIAlertAction(title: "Settings".locatized, style: .default, handler: { (action) -> Void in
            UIApplication.shared.open(URL(string: "App-Prefs:root=GENERAL")!, options: [:], completionHandler: nil)
        })
        alert.addAction(settings)
        self.present(alert, animated: true, completion: nil)
    }
}




