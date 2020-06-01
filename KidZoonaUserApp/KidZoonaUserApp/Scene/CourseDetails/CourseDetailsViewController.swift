//
//  CourseDetailsViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/24/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    

    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var courseImg: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    
    var getCourseName = String()
    var getCourseImg = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseName.text! = getCourseName
        courseImg.image = getCourseImg
        
        reviewTable.separatorColor = UIColor(white: 0.95, alpha: 1)
        reviewTable.delegate = self
        reviewTable.dataSource = self
        
        registerBtn.layer.cornerRadius = 15
        registerBtn.layer.borderWidth = 2
        registerBtn.layer.borderColor = UIColor.blue.cgColor
        registerBtn.layer.shadowOpacity = 0.25
        registerBtn.layer.shadowRadius = 5
        registerBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    

    @IBAction func favouriteBtn(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
   
}
    extension CourseDetailsViewController : UITableViewDelegate , UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 8
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            cell.contentView.backgroundColor = UIColor (white: 0.95, alpha: 1)
            
            return cell
        }
}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



