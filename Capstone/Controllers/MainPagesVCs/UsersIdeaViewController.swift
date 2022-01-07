//
//  UsersIdeaViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 1/6/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

enum ThoughtCategory {
    case general
    case university
    case safeer
    //case advices
}

class UsersIdeaViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var ideaTable: UITableView!
    
    @IBOutlet weak var segmentC: UISegmentedControl!
    
    // Variable
    private var thuoghts = [Thought]()
    private var thoughtCollectionRef: CollectionReference!
    private var thoughtListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        ideaTable.delegate = self
        ideaTable.dataSource = self
        ideaTable.estimatedRowHeight = 80
        ideaTable.rowHeight = UITableView.automaticDimension
        thoughtCollectionRef = Firestore.firestore().collection("thoughts")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        thoughtListener = thoughtCollectionRef.addSnapshotListener { snapshot, error in
            if let err = error{
               debugPrint("Error fetching docs:\(err)")
            }else {
                self.thuoghts.removeAll()
                guard let snap = snapshot else {return}
                for document in snap.documents{
                    let data = document.data()
                    let userN = data["userN"] as? String ?? "Anonymous"
                    let TxtThought = data["TxtThought"] as? String ?? "txt"
              let newthought = Thought(userN: userN, TxtThought: TxtThought)
                    self.thuoghts.append(newthought)
                }
                self.ideaTable.reloadData()
            }
            
        }

        }
    
    override func viewWillDisappear(_ animated: Bool) {
        thoughtListener.remove()
    }
    
    @IBAction func categoryChange(_ sender: Any) {
        
    
    }

}

extension UsersIdeaViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thuoghts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? IdeasTableViewCell {
            cell.configureCell(thought:thuoghts[indexPath.row])
            return cell
        }else {
          return UITableViewCell()
            
        }

    }
    
}
    
    
    
    
    
    
    
//                    let timestamp = data ["timestamp"] as? Date ?? Date()
//                    let numLikes  = data["numLikes"] as? Int ?? 0
//                    let numComments = data["numComments"] as? Int  ?? 0
//                    let documentId = document.documentID
    
//        thoughtCollectionRef.getDocuments { snapshot, error in
//            if let err = error{
//               debugPrint("Error fetching docs:\(err)")
//            }else {
//                guard let snap = snapshot else {return}
//                for document in snap.documents{
//                    let data = document.data()
//                    let userN = data["userN"] as? String ?? "Anonymous"
//                    let timestamp = data ["timestamp"] as? Date ?? Date()
//                    let ideaTxt = data["ideaTxt"] as? String ?? ""
//                    let numLikes  = data["numLikes"] as? Int ?? 0
//                    let numComments = data["numComments"] as? Int  ?? 0
//                    let documentId = document.documentID
//                 let newthought = Thought(userN: userN, ideaTxt: ideaTxt)
//                    self.thuoghts.append(newthought)
//                }
//                self.ideaTable.reloadData()
//            }
