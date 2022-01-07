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

class MainSubjectViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    
    let db = Firestore.firestore()

    var mainSubjects : [SubjectList] = [SubjectList(subjectTitle: "How to rent Apartement", subjectImage: UIImage(named: "house")!), SubjectList(subjectTitle: "How to open bank accont in USA", subjectImage: UIImage(named:"bank")!), SubjectList(subjectTitle: "Saudi Clubs in USA",subjectImage: UIImage(named:"saudiClub")!), SubjectList(subjectTitle: "Emergency Contact",subjectImage: UIImage(named:"contact")!)]
    
    let imageData = [UIImage(named:"4")!,UIImage(named: "5")!,UIImage(named:"6")!,UIImage(named:"7")!]
    let dataQuotoLabel = ["Your best Friend during your study","Just Start","Your Giude","No lost with Student Giude in USA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTable.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        mainTable.delegate = self
        mainTable.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.mainTable.rowHeight = UITableView.automaticDimension;
        
        loadMainSubject()
 
        // Do any additional setup after loading the view.
    }
    
    func loadMainSubject(){
        if Auth.auth().currentUser?.email != nil{
            db.collection("mainSubjects").addDocument(data:["subjectTitle" :"",  "subjectImage": ""])
            mainSubjects = [SubjectList(subjectTitle: "How to rent Apartement", subjectImage: UIImage(named: "house")!), SubjectList(subjectTitle: "How to open bank accont in USA", subjectImage: UIImage(named:"bank")!), SubjectList(subjectTitle: "Saudi Clubs in USA",subjectImage: UIImage(named:"saudiClub")!), SubjectList(subjectTitle: "Emergency Contact",subjectImage: UIImage(named:"contact")!)]
        
        }
            }
        
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
    
        return cell
    
    }else{
    
    }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CoreSubjectsViewController") as? CoreSubjectsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
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
