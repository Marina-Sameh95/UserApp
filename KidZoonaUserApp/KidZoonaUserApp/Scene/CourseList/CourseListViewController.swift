//
//  CourseListViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/22/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class CourseListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var tableView: UITableView!
    
    var name: NSArray = []
    var imageArray:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        
        name = ["Wedo","EV3","Art","Drawing","Music","Music","chess"]
        imageArray = [UIImage(named: "course1"),UIImage(named: "course2"),UIImage(named: "course3"),UIImage(named: "course4"),UIImage(named: "course5"),UIImage(named: "course6"),UIImage(named: "course7")!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseListCell
        cell.contentView.backgroundColor = UIColor (white: 0.95, alpha: 1)
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetails = UIStoryboard(name: "CourseList", bundle: nil).instantiateViewController(withIdentifier: "CourseDetails")
        
        self.navigationController?.pushViewController(courseDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    

}
