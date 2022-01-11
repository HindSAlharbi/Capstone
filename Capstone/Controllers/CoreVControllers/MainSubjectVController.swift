//
//  MainSubjectViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/15/21.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class MainSubjectVController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    
    let db = Firestore.firestore()
    var mainSubjects = [SubjectList]()
    
    private var mainCollectionRef: CollectionReference!
    private var mainListener: ListenerRegistration!
    
    let imageData = [UIImage(named:"4")!,UIImage(named: "5")!,UIImage(named:"6")!,UIImage(named:"7")!]
    let dataQuotoLabel = ["Your best Friend during your study","Just Start","Your Giude","No lost with Student Giude in USA"]
    
    let mainTableImage = [UIImage(named: "house")!,UIImage(named: "bank")!, UIImage(named: "saudiClub")!,UIImage(named: "contact")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTable.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        mainTable.delegate = self
        mainTable.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.mainTable.rowHeight = UITableView.automaticDimension;
        if   ((Auth.auth().currentUser) != nil) {
        mainCollectionRef = Firestore.firestore().collection("mainSubjects")
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainListener = mainCollectionRef.addSnapshotListener { snapshot, error in
            if let err = error{
               debugPrint("Error fetching docs:\(err)")
            }else {
                self.mainSubjects.removeAll()
                guard let snap = snapshot else {return}
                for document in snap.documents{
                    let data = document.data()
                    let subjectTitle = data["subjectTitle"] as? String ?? ""
                    let maintimestamp = data ["maintimestamp"] as? Date ?? Date()
                    let numComment = data["numComment"] as? Int  ?? 0
                    let documentId = document.documentID
                    //let subjectImage = data["subjectImage"] as? UIImage(named: "") ?? " 0"
                    let numLike  = data["numLike"] as? Int ?? 0

                    let main = SubjectList(subjectTitle: subjectTitle, numComment: numComment, numLike: numLike, documentId: documentId, maintimestamp: maintimestamp)
                    self.mainSubjects.append(main)
                }
                self.mainTable.reloadData()
            }
        }
    }
    
    func setListener() {


        mainListener = mainCollectionRef
                .order(by: "numLike", descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching docs: \(err)")
                    } else {
                        self.mainSubjects.removeAll()
//                        self.mainSubjects = SubjectList.parseData(snapshot: snapshot)
                        self.mainTable.reloadData()
                    }
            }
        }
    

}
// MARK: Tableview delegate and datasource

extension MainSubjectVController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainSubjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainSubjectsTableViewCell{
            
            cell.titlelable.text = self.mainSubjects[indexPath.row].subjectTitle
            cell.imageTable.image = mainTableImage[indexPath.row]
            cell.configureCell(subjectList: mainSubjects[indexPath.row])
             

        return cell
    }else{
    
    }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CoreSubjectsViewController") as? SubjectDetailVController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
    
// MARK: Extension for Collectionview delegate and datasource

extension MainSubjectVController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "celll", for: indexPath) as! MainCollectionViewCell
        cell1.imagePro.image = imageData[indexPath.row]
        cell1.lableCollection.text = dataQuotoLabel[indexPath.row]
        return cell1
    }
}



