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



class ProfileViewController: UIViewController{
    
    @IBOutlet weak var emailtextfiled: UITextField!
    @IBOutlet weak var firstNameProfile: UITextField!
    @IBOutlet weak var lastNameProfile: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tapToCahnePhoto:
    UIButton!
    
    var user: User?
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //present(imagePicker, animated: true, completion: nil)
        
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
            self.user = user
            self.emailtextfiled.text = user.email
            self.firstNameProfile.text = user.firstName
            self.lastNameProfile.text = user.lastName
            self.profileImage.image = user.proImage
        }
        
        if Auth.auth().currentUser?.uid == nil {
        }else{
        }
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    func update() {
        guard let user = user else { return  }
        
        UserApi.updateUserInfo(currentUser: user, uid: Auth.auth().currentUser?.uid ?? "", firstName: firstNameProfile.text ?? "", lastName: lastNameProfile.text ?? "")
        
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        
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
    
    func checkPermission(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                ()
            })
            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            } else {
                PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
            }
        }
        
        func requestAuthorizationHandler(status:PHAuthorizationStatus){
            
            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
                print("we have access to photo")
            }else {
                print("we do not have access to photo")
            }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            print(url)
            uploadToCloud(fileURL: url)
        }
        dismiss(animated: true, completion: nil)
    }
    func uploadToCloud(fileURL: URL){
        let storage = Storage.storage()
        let data = Data()
        let storageRef = storage.reference()
        let localFile = fileURL
        let photoRef = storageRef.child("uploadPhotoOne")
        let uploadTask = photoRef.putFile(from: localFile, metadata: nil) { (metadata , err) in
            guard metadata != nil else {
                print(err)
                return
            }
            print("photo Upload")
        }
    }
    
}
extension ProfileViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let pickedImage = info["UIImagePickerEditedImage"] as? UIImage{
            self.profileImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//UIImagePickerEditedImage

//@objc func handleSelectProfileImageView(){
//    print("tap")
//
//    //let pickController = UIImagePickerController()
//    //pickController.delegate = self
//    //present(picker, animated: true, completion: nil)
//}

//    @IBAction func selectImage(_ sender: Any) {
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let imagesRef = storageRef.child("uploadPhotoOne")
//        var spaceRef = storageRef.child("uploadPhotoOne")
////        let storagePath = "\(gs:capstone-10031.appspot.com)uploadPhotoOne"
////        spaceRef = storage.reference(forURL: storagePath)
//
//        //profileImage.image? = UIImage(systemName: reg)
//
//
//
//    }
//
//        let tapGestuew = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleSelectProfileImageView))
//        profileImage.addGestureRecognizer(tapGestuew)
//        profileImage.isUserInteractionEnabled = true
//        let imageTTap = UITapGestureRecognizer(target: self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
