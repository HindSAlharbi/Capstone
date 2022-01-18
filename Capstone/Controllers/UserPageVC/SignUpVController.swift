//
//  LogPageViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/9/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpVController: UIViewController {
    
    // Outlets
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var wrongTextField: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var regBtn: UIButton!
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        textlabel()
        regBtn.layer.cornerRadius = 10
    }
    func signUP(){
        if let email = emailTextFiled.text ,  let password = passwordTextFiled.text, let first = firstNameTextField.text{
            Auth.auth().createUser(withEmail: email, password: password)  { authResult, error in
                guard let uses = authResult?.user, error == nil else {
                            print("email:\(String(describing: authResult?.user.email))")
                            print("uid:\(String(describing: authResult?.user.uid))")
                            return
                        }
                UserApi.addUser(uid: authResult?.user.uid ?? "", email: self.emailTextFiled.text ?? "", firstName: self.firstNameTextField.text ?? "", lastName: self.lastNameTextField.text ?? "", dataCreated: Data() , completion:  { check in
                            if check {
                                print("Done saving in Database")
                                self.performSegue(withIdentifier: Constants.mainPage, sender: nil)
                            } else {
                            }
                        })
                    }
                }
}
    @IBAction func homeBtn(_ sender: Any) {
        signUP()
    }
}
extension SignUpVController{
    
    func textlabel(){
        var charIndex1 = 0.0
        let titelText = "Student Guide".locatized
        for letter in titelText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex1, repeats: false) { (timer )in
                self.wrongTextField?.text?.append(letter)
            }
            charIndex1 += 1
        }
    }
}
    
