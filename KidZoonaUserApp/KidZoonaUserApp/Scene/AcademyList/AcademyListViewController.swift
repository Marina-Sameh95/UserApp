//
//  AcademyListViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/1/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos

class AcademyListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
