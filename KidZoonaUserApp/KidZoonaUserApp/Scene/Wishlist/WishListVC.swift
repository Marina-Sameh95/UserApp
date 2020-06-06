//
//  WishListVC.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/27/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos

class WishListVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    var name: NSArray = []
    var imgArr: NSArray = []
    var academyName: NSArray = []
    var date: NSArray = []
    var cardView: DesignCourseList!
    var rate: CosmosView!
    var favouriteBtn: RoundedBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        name = ["Wedo","Drawing","Music","chess"]
        imgArr = [UIImage(named: "course1")!,UIImage(named: "course4")!,UIImage(named: "course5")!,UIImage(named: "course7")!]
        academyName = ["Metanoia", "Treasures", "Metanonia", "KDC"]
        date = ["1/6/2020", "5/6/2020", "10/6/2020", "12/6/2020"]
        
        setUpNavigationBarItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Wish List"
        
    }
    
    private func setUpNavigationBarItems(){
        let barTitle = "Wishlist"
        navigationItem.title = barTitle
        navigationController?.navigationBar.barTintColor = .warmGrey
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WishTableViewCell
        
        cell.courseImg.image = imgArr[indexPath.row] as! UIImage
        cell.courseName.text! = name[indexPath.row] as! String
        cell.academyName.text! = academyName[indexPath.row] as! String
        cell.courseDate.text! = date[indexPath.row] as! String
     //   cell.cardDesign.viewWithTag(1) = cardView[indexPath.row] as! DesignCourseList
     //   cell.favBtn.buttonType = favouriteBtn[indexPath.row] as! UIButton
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    
}

