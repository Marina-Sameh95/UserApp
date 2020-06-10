//
//  CourseListViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/22/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Firebase

class CourseListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
//    var dbRef : DatabaseReference?
    var coursesArr = [Course]()
    
    @IBOutlet weak var tableView: UITableView!
    
//    var name: NSArray = []
//    var imageArray:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        
//        name = ["Wedo","EV3","Art","Drawing","Music","Music","chess"]
//        imageArray = [UIImage(named: "course1"),UIImage(named: "course2"),UIImage(named: "course3"),UIImage(named: "course4"),UIImage(named: "course5"),UIImage(named: "course6"),UIImage(named: "course7")!]
        
        
//        dbRef = Database.database().reference()
        
//        getCoursesDtata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Courses"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return name.count
        return coursesArr.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseListCell
        cell.contentView.backgroundColor = UIColor (white: 0.95, alpha: 1)
        
        cell.courseObj = coursesArr[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let courseDetails = UIStoryboard(name: "CourseList", bundle: nil).instantiateViewController(withIdentifier: "CourseDetails")
//
//        self.navigationController?.pushViewController(courseDetails, animated: true)
        
        let selectedCourse = coursesArr[indexPath.row]
        
        performSegue(withIdentifier: "toCourseDetails", sender: selectedCourse)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identString = segue.identifier, let identifier = SegueIndentifier(rawValue: identString) else {
            super.prepare(for: segue, sender: sender)
            return
        }
        
        switch identifier {
        case .showDetails: if let indexPath = tableView.indexPathForSelectedRow{
            let course = coursesArr[indexPath.row]
            let controller = (segue.destination as! UINavigationController).topViewController as! CourseDetailsViewController
            controller.currentCourse = course as! Course
            controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
}

extension CourseListViewController{
    
    enum SegueIndentifier : String{
        case showDetails = "toCourseDetails"
    }

    
//    func getCoursesDtata(){
//
//        let academiesRef = dbRef?.child("Academies")
//        academiesRef?.observe(.childAdded, with: { (snapshot) in
//            let coursesSnapshot = snapshot.childSnapshot(forPath: "courses")
//            print("CourseTree\(coursesSnapshot)")
//            var coursesKeysArr : [String] = []
//            for courseChild in coursesSnapshot.children{
//                let courseSnap = courseChild as! DataSnapshot
//                print("courseNode\(courseSnap)")
//                let courseKey = courseSnap.key
//                coursesKeysArr.append(courseKey)
//                print("AllCourseseys\(coursesKeysArr)") // till here its okay
//
//                for courseId in coursesKeysArr{
//                    let courseObj = courseSnap.value as! [String : Any]
//                    var courseInfo =  courseObj["information"] as? [String : Any]
//                    courseInfo?["key"] = courseId
//                    let courseInfoDict = Course(dictionary: courseInfo!)
//                    self.coursesArr.append(courseInfoDict)
//                    self.tableView.reloadData()
//                    print("coursesArray\(self.coursesArr)")
//
//
//                }
//
////                let courseInfoSnap = coursesSnapshot.childSnapshot(forPath: "information")
////                print("courseInfoDictionary\(courseInfoSnap)")
////                for courseInfoChild in courseInfoSnap.children{
////                    let snapCourse = courseInfoChild as! DataSnapshot
////                    let courseDict = snapCourse.value as! [String : Any]
////                    let courseInfoDict = Course(dictionary: courseDict)
////                    self.coursesArr.append(courseInfoDict)
////                    print("coursesArray\(self.coursesArr)")
////                    print("courseDictionary\(courseDict)")
////                    self.tableView.reloadData()
////                }
//            }
//        })
//
//    }
    
//    func getCoursesRates() {
//        
//    }

}
