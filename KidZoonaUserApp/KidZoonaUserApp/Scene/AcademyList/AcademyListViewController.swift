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
    var academiesArr = [Academy]()

    
    @IBOutlet weak var tableView: UITableView!
    
    var imgArr: NSArray = []
    var academyName: NSArray = []
    var rate: CosmosView!
    var cardView: DesignCourseList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imgArr = [UIImage(named: "academy1")!,UIImage(named: "academy3")!,UIImage(named: "academy2")!,UIImage(named: "academy4")!]
        academyName = ["Metanoia", "Treasures", "KDC", "Creative Minds"]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Academy"
        
        dbRef = Database.database().reference()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return academyName.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AcademyTableViewCell
        
        cell.academyImg.image = imgArr[indexPath.row] as! UIImage
        cell.academyName.text! = academyName[indexPath.row] as! String
        //   cell.cardDesign.viewWithTag(1) = cardView[indexPath.row] as! DesignCourseList
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let academyDetails = UIStoryboard(name: "ListOfAcademies", bundle: nil).instantiateViewController(withIdentifier: "AcademyProfile")
        
        self.navigationController?.pushViewController(academyDetails, animated: true)

    }

}

extension AcademyListViewController{
    
    fileprivate func getAcademiesData(){
        let academiesRef = dbRef?.child("Academies")
        academiesRef?.queryOrderedByKey().observe(.value, with: { (snapshot) in
            let infoSnap = snapshot.childSnapshot(forPath: "Information")
            let academyDict = infoSnap.value as! [String : Any]
            let academyData = Academy(dictionary: academyDict)
            self.academiesArr.append(academyData)
            
//            let academyName = academyDict["name"] as! String
//            let academyImg = academyDict["image"] as! String
//            let academyRate = academyDict["rate"] as! String
        })
    }
}
