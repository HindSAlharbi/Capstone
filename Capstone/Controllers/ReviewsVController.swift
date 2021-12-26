//
//  ReviewsVController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/23/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class ReviewsVController: UIViewController{
    
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var reviewTextField: UITextField!
    let db = Firestore.firestore()
    
    var messages = [messageConstants(body: "messages", sender: "email")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            loadMessages()
        
    }
    func loadMessages(){
        
        db.collection("messages").getDocuments { (querySnapshot, error) in
            self.messages = []
            
            if let e = error{
                print("There was issue  retrievining data from Firestore.\(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let messagebody = data["message"] as? String {
                          let newMessage = messageConstants(body: messagebody, sender: sender)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.reviewTable.reloadData()
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func sencdBtn(_ sender: UIButton) {
        
        if  let messageBody = reviewTextField.text ,
            let messageSender = Auth.auth().currentUser?.uid{
            db.collection("messages").addDocument(data: ["sender": messageSender,"message":messageBody]) { (error) in
                if let e = error{
                    print("There was an issue saving data to firebase\(e)")
                }else{
                    print("successfully saved data")
                }
            }
        }
        
    }
}
extension ReviewsVController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

