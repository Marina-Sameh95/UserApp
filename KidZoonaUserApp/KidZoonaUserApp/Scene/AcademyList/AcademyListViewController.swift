//
//  AcademyListViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/1/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class AcademyListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var dbRef : DatabaseReference?
    var academiesInfoArr = [Academy]()

    @IBOutlet weak var tableView: UITableView!

//    var imgArr: NSArray = []
//    var academyName: NSArray = []
//    var rate: CosmosView!
//    var cardView: DesignCourseList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self

//        imgArr = [UIImage(named: "academy1")!,UIImage(named: "academy3")!,UIImage(named: "academy2")!,UIImage(named: "academy4")!]
//        academyName = ["Metanoia", "Treasures", "KDC", "Creative Minds"]
        
        
        dbRef = Database.database().reference()
        getAcademiesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Academies"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return academiesInfoArr.count
//        return academyName.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AcademyTableViewCell
        
//        cell.academyImg.image = imgArr[indexPath.row] as! UIImage
//        cell.academyName.text! = academyName[indexPath.row] as! String
//        cell.cardDesign.viewWithTag(1) = cardView[indexPath.row] as!
        
        cell.academyName.text! = academiesInfoArr[indexPath.row].name
        // TODO
//        cell.academyImage.image = academiesInfoArr[indexPath.row].image
        //rating
        cell.academyRateView.rating = Double(academiesInfoArr[indexPath.row].rate)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let academyDetails = UIStoryboard(name: "ListOfAcademies", bundle: nil).instantiateViewController(withIdentifier: "AcademyProfile")
        
        let academyProfileVC = AcademyProfileVC()
        academyProfileVC.currentAcademy = academiesInfoArr[indexPath.row]
        
        self.navigationController?.pushViewController(academyDetails, animated: true)

    }

}

extension AcademyListViewController{
    
    fileprivate func getAcademiesData(){
        
        let academiesRef = dbRef?.child("Academies")
        academiesRef?.queryLimited(toLast: 10).observe(.value, with: { [weak self] snapshot in
            
            if let academiesList = snapshot.value as? [String : Any]{
                
                let academiesIds = academiesList.keys
                print("AllKey\(academiesIds)")
                for id in academiesIds{
                    let academy = academiesList[id] as? [String : Any]
                    
                    var information = academy?["Information"] as? [String : Any]
                    information?["key"] = id
                    let academyInfoDict = Academy(dictionary: information!)
                    self?.academiesInfoArr.append(academyInfoDict)
                    self?.tableView.reloadData()
                    
                    print("SingleAcademy\(String(describing: academy))")
                    print("SingleInfoDictonary\(String(describing: information))")
                    
                }
            }
            
        })
//        academiesRef?.queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//            let infoSnap = snapshot.childSnapshot(forPath: "Information")
//            
//            for child in infoSnap.children{
//                let acadenyInfoSnap = child as! DataSnapshot
//                let academyInfoDict = acadenyInfoSnap.value as! [String : Any]
//                let academyInfo = Academy(dictionary: academyInfoDict)
//                self.academiesInfoArr.append(academyInfo)
//                self.tableView.reloadData()
//                print("informationBulidedDict\(academyInfo)")
//                //            print("informationBulidedDictArray\(self.academiesInfoArr)")
            
//            }
        
        
//            print("academyInformationSnapshot\(infoSnap)")
//            let infoDict = infoSnap.value as! [String : Any]
//
//            let academyInfo = Academy(dictionary: infoDict)
//            self.academiesInfoArr.append(academyInfo)
//
//            let academyName = academyInfo.name
//            let academyImage = academyInfo.image
//
//            self.tableView.reloadData()

//
//            print("academyNameFromAcademyInfoBulidedDict\(academyName)")
//            print("academyImgFromAcademyInfoBulidedDict\(academyImage)")
//
//            print("informationBulidedDict\(academyInfo)")
//            print("informationBulidedDictArray\(self.academiesInfoArr)")
//
////            let academyName = infoDict["name"] as! String
////            let academyImg = infoDict["image"] as! String
////            let academyRate = infoDict["rate"] as! String
//        })
    }
    
    
    func calcAvgRatesForAcadmies(rates : [Double] ) -> Double{
        let sumArr = rates.reduce(0 , +)
        let avgRates = Double(sumArr) / Double(rates.count)
        
        return avgRates
    }
    
    private func upadateAcadmyRateWithDefultValue(){
        let rateDictValue = ["rate" : 2.5]
        
        let academiesRef = dbRef?.child("Academies")
        academiesRef?.observe(.childAdded, with: { (snapshot) in
            
            if let academiesList = snapshot.value as? [String : Any]{
                
                let academiesIds = academiesList.keys
                print("AllKey\(academiesIds)")
                for id in academiesIds{
                    let infoRef = academiesRef?.child(id).child("Information")
                    infoRef?.updateChildValues(rateDictValue, withCompletionBlock: { (error, dbRef) in
                        if let err = error {
                            print("Cannot Push defult rate Value", err.localizedDescription)
                        }
                        print("Rate's defult Value pushed Successfully")
                    })
                    
                }
            }
            
        })

        
//        infoRef?.updateChildValues(rateDictValue, withCompletionBlock: { (error, dbRef) in
//
//            if let err = error {
//                print("Cannot Push rate Value", err.localizedDescription)
//            }
//
//            print("Rate pushed Successfully")
//        })
        
    }

    
}
