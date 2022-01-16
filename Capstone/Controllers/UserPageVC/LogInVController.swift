//
//  LogInVController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/9/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInVController: UIViewController {
    
    // Outlets
    @IBOutlet weak var logInTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var studentGuideLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserInfor()
        labeltext3()
        loginBtn.layer.cornerRadius = 10
        registerBtn.layer.cornerRadius = 10

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true

    }
    // IBAction for register
    @IBAction func registerBtn(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.register, sender: nil)
    }
    // IBAction for LogIn
    @IBAction func LogInToHome(_ sender: Any) {
        if let email = logInTextField.text, let password = passTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                if let e  = error{
                    let alert = UIAlertController(title: "Error".locatized, message: "Pleas fill all the fileds.".locatized, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                    
                    self?.present(alert, animated: true)
                    print(e)
                }else{
                    self?.performSegue(withIdentifier: Constants.loginHome, sender: self)
                }
            }
        }
        
    }
    func checkUserInfor(){
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: Constants.loginHome, sender: self)
        }
    }
}
extension LogInVController{
    func labeltext3(){
        var charIndex3 = 0.0
        let titelText = "Student Guide".locatized
        for letter in titelText{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex3, repeats: false) { (timer )in
                self.studentGuideLabel?.text?.append(letter)
            }
            charIndex3 += 1
        }
    }
}

