//
//  MainSubjectViewController.swift
//  Capstone
//
//  Created by Hind Alharbi on 12/15/21.
//

import UIKit

class MainSubjectViewController: UIViewController {

    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let data = ["How to rent Apartement","How to open bank accont in USA","Saudi Clubs in USA","Emergency Contact"]
    
    let imageDataTable = [UIImage(named:"house")!,UIImage(named: "bank"),UIImage(named:"saudiClub")!,UIImage(named:"contact")!]
    
    let imageData = [UIImage(named:"3")!,UIImage(named: "5")!,UIImage(named:"contact")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTable.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.mainTable.delegate = self
        self.mainTable.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
    // Do any additional setup after loading the view.
        
    }
}

// MARK: Tableview delegate and datasource

extension MainSubjectViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell{
            cell.titlelable.text = self.data[indexPath.row]
            cell.imageTable.image = imageDataTable[indexPath.row]
            return cell
        }
                
        return UITableViewCell()
    }
}
 
extension MainSubjectViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "celll", for: indexPath) as! CellCollectionViewCell
        cell1.imagePro.image = imageData[indexPath.row]
        return cell1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    }




// var timer: Timer?
// var currentCellIndex = 0
//startTimer()
//    func startTimer(){
//        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(nextIndex), userInfo: nil, repeats: true)
//
//    }
//    @objc func nextIndex(){
//        if currentCellIndex < imageData.count - 1{
//            currentCellIndex += 1
//        }else {
//           currentCellIndex = 0
//        }
        
        
//        currentCellIndex += 1
//        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
//
//    }
