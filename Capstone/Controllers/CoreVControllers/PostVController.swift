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


class PostVController: UIViewController, UITextViewDelegate {
   
    // Outlets
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var thoughtTxt: UITextView!
    @IBOutlet weak var postBtnn: UIButton!
    
    // Variables
    private var selectedCategory = ThoughtCategory.general.rawValue
    
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

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }

    @IBAction func categoryChange(_ sender: Any) {
        
        switch categorySegment.selectedSegmentIndex{
        case 0:
            selectedCategory = ThoughtCategory.general.rawValue
        case 1:
            selectedCategory = ThoughtCategory.university.rawValue
        default:
            selectedCategory = ThoughtCategory.safeer.rawValue
        }
        

    }
   
    //MARK: load table data to firebase

    @IBAction func postBtnTapped(_ sender: Any) {
        if (Auth.auth().currentUser != nil){
            
        guard let userN = userNameTxt.text else{return}
        
        Firestore.firestore().collection("thoughts").addDocument(data: [
           
            "userN": userN,
            "TxtThought": thoughtTxt.text!,
            "category" : selectedCategory,
            "numComments" : 0,
            "numLikes" : 0,
            "timestamp" : FieldValue.serverTimestamp(),
        ]) { err in
            if let err = err {
                debugPrint("Error adding document:\(err)")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

}








//FieldValue.serverTimestamp()


//"category": selectedCategory
//"numComments": 0
//"numLikes": 0
//"timestamp": FieldValue.serverTimestamp()
