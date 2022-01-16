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

class UserPostVController: UIViewController {
    // outlets
    @IBOutlet weak var ideaTable: UITableView!
    @IBOutlet weak var segmentC: UISegmentedControl!
    // Variables
    private var thuoghts = [Thought]()
    private var thoughtCollectionRef: CollectionReference!
    private var thoughtListener: ListenerRegistration!
    private var selectedCategory = ThoughtCategory.popular.rawValue
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ideaTable.delegate = self
        ideaTable.dataSource = self
        ideaTable.estimatedRowHeight = 80
        ideaTable.rowHeight = UITableView.automaticDimension
        if   ((Auth.auth().currentUser) != nil) {
        thoughtCollectionRef = Firestore.firestore().collection("thoughts")
    }
}
    @IBAction func addThought(_ sender: Any) {
     performSegue(withIdentifier: "add", sender: nil)
    }
    //MARK: load  data to firebase
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user == nil {
            } else {
                self.setListener()
            }
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        if thoughtListener != nil {
          thoughtListener.remove()
        }
    }
    @IBAction func categoryChange(_ sender: Any) {
        guard ((Auth.auth().currentUser?.uid) != nil) else {return}
        switch segmentC.selectedSegmentIndex{
        case 0:
            selectedCategory = ThoughtCategory.popular.rawValue
        case 1:
            selectedCategory = ThoughtCategory.safeer.rawValue
        case 2:
            selectedCategory = ThoughtCategory.laws.rawValue
        default:
            selectedCategory = ThoughtCategory.forSell.rawValue
        }
        thoughtListener.remove()
        setListener()
    }
    func setListener() {
        if selectedCategory == ThoughtCategory.popular.rawValue{
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
        } else {
            thoughtListener = thoughtCollectionRef
        .whereField("category", isEqualTo: selectedCategory)
        .order(by: "timestamp", descending: true)
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
// MARK: Tableview delegate and datasource
extension UserPostVController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thuoghts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tablecell, for: indexPath) as? UsersPostTableViewCell {
            cell.configureCell(thought:thuoghts[indexPath.row])
            return cell
        }else {
          return UITableViewCell()
            
        }
    }
}
// enum segment category
enum ThoughtCategory: String {
    case popular = "Popular"
    case safeer = "safeer"
    case laws = "laws"
    case forSell = "forSell"
}








 
