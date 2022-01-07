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
    
    // Variables
    private var selectedCategory = ThoughtCategory.general
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postBtnn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "My suggestion..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    //MARK: load messages to firebase
   
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func categoryChange(_ sender: Any) {
        
        
        switch categorySegment.selectedSegmentIndex{
    
        case 0:
            selectedCategory = ThoughtCategory.general
        case 1:
            selectedCategory = ThoughtCategory.university
        default:
            selectedCategory = ThoughtCategory.safeer
//        default:
//            selectedCategory = ThoughtCategory.advices
        }

    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let username = userNameTxt.text else{return}
        
        Firestore.firestore().collection("thoughts").addDocument(data: [
            
            "userN": userNameTxt.text!,
            "TxtThought": thoughtTxt.text!
        
        ]) { err in
            if let err = err {
                debugPrint("Error adding document:\(err)")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
//"category": selectedCategory
//"numComments": 0
//"numLikes": 0
//"timestamp": FieldValue.serverTimestamp()
