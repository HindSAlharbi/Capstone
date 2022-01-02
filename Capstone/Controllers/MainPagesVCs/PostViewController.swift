//
//  ViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/8/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

//thoughtCell
class PostViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var thoughtTxt: UITextView!
    
    @IBOutlet weak var postBtnn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        postBtnn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "My suggestion..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
        
        
    }
    //MARK: load messages to firebase
   
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    @IBAction func categoryChanged(_ sender: Any) {
        
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        
        
    }
}
