//
//  LogPageViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/9/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class SignUpPageViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var emailTextFiled: UITextField!
    
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var wrongTextField: UILabel!
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textlabel0()
        textlabel()
        
    }


    @IBAction func registerBtn(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.register, sender: nil)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.login, sender: nil)
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        if let email = emailTextFiled.text ,  let password = passwordTextFiled.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let er = error {
            
               print(er)// alret
            }else {
                self.performSegue(withIdentifier:Constants.mainPage, sender: self)
            }
        }
        }
    }
    
        
    @IBAction func skipBtnAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.skipToMaine, sender: nil)
    }
    func checkUserInfor(){
        if Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.uid)
        }
    }
}
extension SignUpPageViewController{
    
    func textlabel0(){
        
        var charIndex = 0.0
        let titelText = "Student Gidue"
        for letter in titelText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer )in
                self.titleLable?.text?.append(letter)
            }
           charIndex += 1
        }
        
        
    }

    func textlabel(){
        
        var charIndex1 = 0.0
        let titelText = "Student Gidue"
        for letter in titelText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex1, repeats: false) { (timer )in
                self.wrongTextField?.text?.append(letter)
            }
           charIndex1 += 1
        }
    }
    
}
