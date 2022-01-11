//
//  CommentsVController.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/8/22.
//

import UIKit
import Firebase


class CommentsVController: UIViewController {
   
    // Outlet
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var commentTextFild: UITextField!
   // @IBOutlet weak var keyboardView: UIView!
    
    // Variables
var thought:Thought!
var comments = [Comment]()
var thoughtRef: DocumentReference!
let firestore = Firestore.firestore()
var username: String!
var commentListener : ListenerRegistration!


    override func viewDidLoad() {
        super.viewDidLoad()
        commentTable.delegate = self
        commentTable.dataSource = self
        
        thoughtRef = firestore.collection("thoughts").document(thought.documentId)
        UserApi.getUser(uid: Auth.auth().currentUser?.uid ?? "") { user in
        }
        
        if Auth.auth().currentUser?.uid == nil {
        }else{
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        commentListener = firestore.collection("thoughts").document(self.thought.documentId)
            .collection("comments")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener({ (snapshot, error) in
                
                guard let snapshot = snapshot else {
                    debugPrint("Error fetching comments: \(error!)")
                    return
                }
                
                self.comments.removeAll()
                self.comments = Comment.parseData(snapshot: snapshot)
                self.commentTable.reloadData()
            })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        commentListener.remove()
    }

    @IBAction func addCommentsTapped(_ sender: Any) {
        guard let commentTxt = commentTextFild else {return}
        
        
        firestore.runTransaction({ (transaction, errorPointer) -> Any? in
            let thoughtDocument: DocumentSnapshot
            
            do {
                try thoughtDocument = transaction.getDocument(Firestore.firestore()
                    .collection("thoughts").document(self.thought.documentId))
            } catch let error as NSError {
                debugPrint("Fetch error: \(error.localizedDescription)")
                return nil
            }
            
            guard let oldNumComments = thoughtDocument.data()?["numComments"] as? Int else { return nil }
            
            transaction.updateData(["numComments": oldNumComments + 1], forDocument: self.thoughtRef)
            
            let newCommentRef = self.firestore.collection("thoughts").document(self.thought.documentId).collection("comments").document()
            
            transaction.setData([
                "commentTxt" : commentTxt ,
                "timestamp" : FieldValue.serverTimestamp(),
                "userN" : self.username ?? ""
                ], forDocument: newCommentRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Transaction failed: \(error)")
            } else {
                self.commentTextFild.text = ""
                self.commentTextFild.resignFirstResponder()
            }
        }
    }
}
    // Tableview extension
extension CommentsVController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentTableViewCell{
            cell.configureCell(comment: comments[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}
