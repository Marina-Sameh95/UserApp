//
//  EventTableViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/6/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var name: NSArray = []
    var imgArr: NSArray = []
    var academyName: NSArray = []
    var date: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        name = ["Wedo","Drawing","Music","chess"]
        imgArr = [UIImage(named: "course1")!,UIImage(named: "course4")!,UIImage(named: "course5")!,UIImage(named: "course7")!]
        academyName = ["Metanoia", "Treasures", "Metanonia", "KDC"]
        date = ["1/6/2020", "5/6/2020", "10/6/2020", "12/6/2020"]
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventSegmentTableViewCell
        
        cell.eventImg.image = imgArr[indexPath.row] as! UIImage
        cell.eventName.text! = name[indexPath.row] as! String
        cell.academyName.text! = academyName[indexPath.row] as! String
        cell.eventDate.text! = date[indexPath.row] as! String
        
        return cell
    }
 

}
