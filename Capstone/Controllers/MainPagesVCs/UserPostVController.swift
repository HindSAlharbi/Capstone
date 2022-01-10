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

enum ThoughtCategory: String {
    case general = "general"
    case university = "university"
    case safeer = "safeer"
}

class UserPostVController: UIViewController {
    
    // outlets
    @IBOutlet weak var ideaTable: UITableView!
    @IBOutlet weak var segmentC: UISegmentedControl!
    
    // Variable
    private var thuoghts = [Thought]()
    private var thoughtCollectionRef: CollectionReference!
    private var thoughtListener: ListenerRegistration!
    private var selectedCategory = ThoughtCategory.general.rawValue
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        ideaTable.delegate = self
        ideaTable.dataSource = self
        ideaTable.estimatedRowHeight = 80
        ideaTable.rowHeight = UITableView.automaticDimension
        thoughtCollectionRef = Firestore.firestore().collection("thoughts")
    }
    
    //MARK: load  data to firebase
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
//               self.performSegue(withIdentifier: "loginHome", sender: nil)
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.logOut)
//                self.present(loginVC, animated: true, completion: nil)
            } else {
                self.setListener()
            }
        })
    }
    
    
    

    
    override func viewWillDisappear(_ animated: Bool) {
        if thoughtListener != nil {
          thoughtListener.remove()    }
    }
    @IBAction func categoryChange(_ sender: Any) {
        
        switch segmentC.selectedSegmentIndex{
        case 0:
            selectedCategory = ThoughtCategory.general.rawValue
        case 1:
            selectedCategory = ThoughtCategory.university.rawValue
        default:
            selectedCategory = ThoughtCategory.safeer.rawValue
        }
        
        thoughtListener.remove()
        setListener()
    }

    func setListener() {
        
        if selectedCategory == ThoughtCategory.general.rawValue{
            thoughtListener = thoughtCollectionRef
                .order(by: "numLikes", descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching docs: \(err)")
                    } else {
                        self.thuoghts.removeAll()
                        self.thuoghts = Thought.parseData(snapshot: snapshot)
                        self.ideaTable.reloadData()
                    }
            }
        }
    }
     
}
//MARK: exrension for Post tableView

extension UserPostVController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thuoghts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? UsersPostTableViewCell {
            cell.configureCell(thought:thuoghts[indexPath.row])
            return cell
        }else {
          return UITableViewCell()
            
        }

    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toComments", sender: thuoghts[indexPath.row])
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toComments"{
//            if let destinationVC = segue.destination as? CommentsVController{
//                if let thought = sender as? Thought{
//                    destinationVC.thought = thought
//                }
//            }
//        }
//    }
}











//    override func viewWillAppear(_ animated: Bool) {
//        thoughtListener = thoughtCollectionRef.addSnapshotListener { snapshot, error in
//            if let err = error{
//               debugPrint("Error fetching docs:\(err)")
//            }else {
//                self.thuoghts.removeAll()
//                guard let snap = snapshot else {return}
//                for document in snap.documents{
//                    let data = document.data()
//                    let category = data ["category"] as? String ?? ""
//                    let userN = data["userN"] as? String ?? "Anonymous"
//                    let TxtThought = data["TxtThought"] as? String ?? ""
//                    let timestamp = data ["timestamp"] as? Date ?? Date()
//                    let numComments = data["numComments"] as? Int  ?? 0
//                    let documentId = document.documentID
//                    let numLikes  = data["numLikes"] as? Int ?? 0
//                    let newthought = Thought(userN: userN, TxtThought: TxtThought, numLikes: numLikes, numComments: numComments, timestamp: timestamp, documentId: documentId)
//                    self.thuoghts.append(newthought)
//                }
//                self.ideaTable.reloadData()
//            }
//
//        }
//
//        }
