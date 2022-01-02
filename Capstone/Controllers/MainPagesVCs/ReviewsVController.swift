////
////  ReviewsVController.swift
////  Capstone
////
////  Created by Hind Alharbi on 12/23/21.
////
//
//import UIKit
//import FirebaseAuth
//import Firebase
//import FirebaseStorage
//
//class ReviewsVController: UIViewController, UITextViewDelegate{
//
//    @IBOutlet weak var reviewTable: UITableView!
//
//    @IBOutlet weak var thoughtTxtFiled: UITextView!
//
//    @IBOutlet weak var usernameField: UITextField!
//
//
//    //var userMessage: User?
//
//    let db = Firestore.firestore()
//
//    var messages = [messageConstants(body: "messages", sender: "email", userName: "userName")]
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadMessages()
//        self.navigationItem.setHidesBackButton(true, animated: true)
//
////        self.reviewTable.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellReuseIdentifier: "tableCell")
//
////        self.reviewTable.estimatedRowHeight = 80
////        self.reviewTable.rowHeight = UITableView.automaticDimension
//
//        thoughtTxtFiled.text = "share your thought...."
//        thoughtTxtFiled.textColor = UIColor.lightGray
//        thoughtTxtFiled.layer.cornerRadius = 4
//        usernameField.layer.cornerRadius = 4
//        thoughtTxtFiled.delegate = self
//
//    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        thoughtTxtFiled.text = ""
//        thoughtTxtFiled.textColor = UIColor.darkGray
//    }
//
//    //MARK: load messages to firebase
//
//    func loadMessages(){
//
//
//        db.collection("messages").getDocuments { (querySnapshot, error) in
//            self.messages = []
//
//            if let e = error{
//                print("There was issue  retrievining data from Firestore.\(e)")
//            }else{
//                if let snapshotDocuments = querySnapshot?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        if let sender = data["sender"] as? String, let messagebody = data["message"] as? String,let usernameSender = data["username"] as? String{
//                            let newMessage = messageConstants(body: messagebody, sender: sender, userName: usernameSender)
//                            self.messages.append(newMessage)
//
//                            DispatchQueue.main.async {
//                                self.reviewTable.reloadData()
//                            }
//                        }
//
//                    }
//                }
//            }
//        }
//
//
//    }
//    @IBAction func sendActionBtn(_ sender: UIButton) {
//        if let messageSender = Auth.auth().currentUser?.email , let MessageBody =  thoughtTxtFiled.text, let UsernameSender = usernameField.text{
//
//            db.collection("messages").addDocument(data: ["sender": messageSender,"message":MessageBody, "userName": UsernameSender]) { (error) in
//                if let e = error{
//                    print("There was an issue saving data to firebase\(e)")
//                }else{
//                    print("successfully saved data")
//                }
//            }
//        }
//    }
//
//    }
//
//extension ReviewsVController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//          let cellReview = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
//
////        cellReview.txt.text = messages[indexPath.row].body
////        cellReview.userLabel.text = messages[indexPath.row].userName
//        return cellReview
//
//
//        }
//
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
