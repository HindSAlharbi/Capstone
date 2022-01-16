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

class MainSubjectsVController: UIViewController {
    
    // Outlets
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    // Varabiles
    let db = Firestore.firestore()
    var mainSubjects = [SubjectList]()
    private var mainCollectionRef: CollectionReference!
    private var mainListener: ListenerRegistration!
    
    var collectionImage:NSArray = []
    var collectionLabel: NSArray = []
    var mainTableImage:NSArray = []
    
    var TitleLabel: String!
    var ImageTitle: UIImage!
    var subtitleLabel: String!
    fileprivate var selectedRow: Int?
    var rowSelected : Int?
    var timer : Timer?
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageCollection()
        tableImage()
        startTimer()
        mainTable.delegate = self
        mainTable.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.mainTable.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.mainTable.rowHeight = UITableView.automaticDimension;
        
       if ((Auth.auth().currentUser) != nil) {
        mainCollectionRef = Firestore.firestore().collection("mainSubjects")
        }
    }
    func startTimer(){
      timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    @objc func moveToNextIndex(){
      if currentCellIndex < collectionImage.count - 1{
        currentCellIndex += 1
      }else{
        currentCellIndex = 0
      }
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally , animated: true)
    }
    // func for Table Image
    func tableImage(){
        mainTableImage = [UIImage(named: "house")!,UIImage(named: "bank")!, UIImage(named: "saudiClub")!,UIImage(named: "contact")!]
    }
    // func for Collection Image
    func ImageCollection(){
        collectionImage = [UIImage(named:"15")!,UIImage(named: "16")!,UIImage(named:"17")!,UIImage(named:"18")!,UIImage(named:"19")!]
        collectionLabel = ["Student guide is your best Friend!".locatized,"Just Start!".locatized,"you have to start to be great!".locatized,"Create your futur with us!".locatized,"If opportunity doesn’t knock, build a door!".locatized]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        mainListener = mainCollectionRef.addSnapshotListener { snapshot, error in
            if let err = error{
               debugPrint("Error fetching docs:\(err)")
            }else {
                self.mainSubjects.removeAll()
                guard let snap = snapshot else {return}
                for document in snap.documents{
                    let data = document.data()
                    let subjectTitle = data["subjectTitle"] as? String ?? ""
                    let numComment = data["numComment"] as? Int  ?? 0
                    let documentId = document.documentID
                    let numLike  = data["numLike"] as? Int ?? 0
                    let savedDate = data ["maintimestamp"] as? Timestamp ?? Timestamp(date: Date())
                    let maintimestamp = savedDate.dateValue()
        
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
                        self.mainSubjects = SubjectList.parseData(snapshot: snapshot)
                        self.mainTable.reloadData()
                    }
            }
        }
}
// MARK: Tableview delegate and datasource

extension MainSubjectsVController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainSubjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableCell, for: indexPath) as? MainSubjectsTableViewCell{
            
        cell.imageTable.image = mainTableImage[indexPath.row] as? UIImage
        cell.configureCell(subjectList: mainSubjects[indexPath.row])
            
        return cell
    }else{
    }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch indexPath.row{
        case 0:
            TitleLabel = Constants.RentTitle
            ImageTitle = UIImage(named: "8")
            subtitleLabel = Constants.homeDetils
            performSegue(withIdentifier: Constants.secondPage, sender: nil)
        case 1:
            TitleLabel = Constants.bankAccount
            ImageTitle = UIImage(named: "9")
            subtitleLabel = Constants.bank
            performSegue(withIdentifier: Constants.secondPage, sender: nil)
        case 2:
            if indexPath.row == 2 {
                performSegue(withIdentifier: Constants.clubs, sender: nil)
            }
        case 3:
            TitleLabel = Constants.contact
            ImageTitle = UIImage(named: "10")
            subtitleLabel = Constants.contactDetials
            performSegue(withIdentifier: Constants.secondPage, sender: nil)
        default:
            print("")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.secondPage{
        if let vc = segue.destination as? SubjectdetailsVController{
        vc.TitleLabel = TitleLabel
        vc.ImageTitle = ImageTitle
        vc.subtitleLabel = subtitleLabel
        }
     }
   }
}
// MARK: Extension for Collectionview delegate and datasource
extension MainSubjectsVController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cell, for: indexPath) as! MainCollectionViewCell
        cell1.imagePro.image = collectionImage[indexPath.row] as? UIImage
        cell1.lableCollection.text = collectionLabel[indexPath.row] as? String
        return cell1
    }
}

    

