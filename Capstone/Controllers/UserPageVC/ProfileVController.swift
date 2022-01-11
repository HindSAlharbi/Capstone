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

class ProfileVController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //Outlet
    @IBOutlet weak var emailtextfiled: UITextField!
    @IBOutlet weak var firstNameProfile: UITextField!
    @IBOutlet weak var lastNameProfile: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tapToCahnePhoto:
    UIButton!
    
    // Variables
    var user: User?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custome outlet
        
        imagePicker.delegate = self
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.user = user
            self.emailtextfiled.text = user.email
            self.firstNameProfile.text = user.firstName
            self.lastNameProfile.text = user.lastName
            self.profileImage.image = user.proImage
        }
        
//        if Auth.auth().currentUser?.uid == nil {
//        }else{
//        }
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        checkPermission()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    func update() {
        guard let user = user else { return  }
        
        UserApi.updateUserInfo(currentUser: user, uid: Auth.auth().currentUser?.uid ?? "", firstName: firstNameProfile.text ?? "", lastName: lastNameProfile.text ?? "")
        
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
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
        let alert = UIAlertController(title: "You can change your language by going to your device settings.", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        let settings = UIAlertAction(title: "See Settings", style: .default, handler: { (action) -> Void in
            UIApplication.shared.open(URL(string: "App-Prefs:root=GENERAL")!, options: [:], completionHandler: nil)
        })
        alert.addAction(settings)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkPermission(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
            print("we have access to photo")
        }else {
            print("we do not have access to photo")
        }
    }
    
    func requestAuthorizationHandler(status:PHAuthorizationStatus){
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("we have access to photo")
        }else {
            print("we do not have access to photo")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url)
            uploadToTheClould(fileURL: url)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func uploadToTheClould(fileURL : URL){
        
        let storage = Storage.storage()
        let data = Data()
        let storageRef = storage.reference()
        let localFile = fileURL
        let photoRef = storageRef.child("uploadPhotoTwo")
        let uploadTast = photoRef.putFile(from: localFile, metadata: nil) { (metadata, err) in
            guard let metadata = metadata else{
                print(err?.localizedDescription)
                return
            }
            print("Photo Uploaded")
        }
    }
}

