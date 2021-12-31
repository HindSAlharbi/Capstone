//
//  MainSubjectViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/15/21.
//

import UIKit
import Firebase
import FirebaseStorage

class MainSubjectViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
   //let timestamp: Date
   // let numLikes: Int
   // let numComments: Int
    //let documentId: String
    
    let db = Firestore.firestore()

    let mainSubjects : [SubjectList] = [SubjectList(subjectTitle: "How to rent Apartement", subjectImage: UIImage(named: "house")!, timestamp: Date(), numLikes: 0,numComments: 0,documentId: ""), SubjectList(subjectTitle: "How to open bank accont in USA", subjectImage: UIImage(named:"bank")!,timestamp: Date(),numLikes: 0,numComments: 0, documentId: ""), SubjectList(subjectTitle: "Saudi Clubs in USA",subjectImage: UIImage(named:"saudiClub")!,timestamp: Date(),numLikes: 0,numComments: 0, documentId: ""), SubjectList(subjectTitle: "Emergency Contact",subjectImage: UIImage(named:"contact")!, timestamp: Date(),numLikes: 0,numComments: 0, documentId: "")]
    
    let imageData = [UIImage(named:"4")!,UIImage(named: "5")!,UIImage(named:"6")!,UIImage(named:"7")!]
    let dataQuotoLabel = ["Your best Friend during your study","Just Start","Your Giude","No lost with Student Giude in USA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTable.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.mainTable.delegate = self
        self.mainTable.dataSource = self
        self.mainTable.rowHeight = UITableView.automaticDimension;
        //self.tableView.estimatedRowHeight = 44.0;
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //loadData()
        
        // Do any additional setup after loading the view.
    }
//    func loadData(){
//
//        db.collection("mainSubjects").document("").setData([
//            "subjectTitle": "How to rent Apartement",
//           "subjectImage": "house",
//           "timestamp": FieldValue.serverTimestamp(),
//       "numComments" : 0,
//         "numLikes" : 0,
//
//         ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//             } else {
//                 print("Document successfully written!")
//             }
//         }
        
        
    
 

    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    @IBAction func nextPage(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }

}

// MARK: Tableview delegate and datasource

extension MainSubjectViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainSubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell{
            
            cell.titlelable.text = self.mainSubjects[indexPath.row].subjectTitle
            cell.imageTable.image = mainSubjects[indexPath.row].subjectImage
            cell.configureCell(subject: mainSubjects[indexPath.row])
            
            return cell
        }else{
        
        return UITableViewCell()
        }
    }
}
// MARK: Collectionview delegate and datasource
extension MainSubjectViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "celll", for: indexPath) as! CellCollectionViewCell
        cell1.imagePro.image = imageData[indexPath.row]
        cell1.lableCollection.text = dataQuotoLabel[indexPath.row]
        return cell1
    }
}




















//    let data = ["How to rent Apartement","How to open bank accont in USA","Saudi Clubs in USA","Emergency Contact"]

//    let labelTitel = ["Make Your Journe memerale","Here to start","Hind"]

//    let imageDataTable = [UIImage(named:"house")!,UIImage(named: "bank"),UIImage(named:"saudiClub")!,UIImage(named:"contact")!]
