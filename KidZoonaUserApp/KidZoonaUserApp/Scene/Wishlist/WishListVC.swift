//
//  WishListVC.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/27/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher
import Firebase

class WishListVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    var dbRef : DatabaseReference?
    var wishlistedCoursesIds = [String]()
    
    var wishlistedCoursesArr = [Course]()
    
//    var name: NSArray = []
//    var imgArr: NSArray = []
//    var academyName: NSArray = []
//    var date: NSArray = []
    
//    var cardView: DesignCourseList!
//    var rate: CosmosView!
//    var favouriteBtn: RoundedBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        name = ["Wedo","Drawing","Music","chess"]
//        imgArr = [UIImage(named: "course1")!,UIImage(named: "course4")!,UIImage(named: "course5")!,UIImage(named: "course7")!]
//        academyName = ["Metanoia", "Treasures", "Metanonia", "KDC"]
//        date = ["1/6/2020", "5/6/2020", "10/6/2020", "12/6/2020"]
        
//        setUpNavigationBarItems()
        
        dbRef = Database.database().reference()
        
        retriveWishListedCourses()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Wishlist"
        
    }
    
//    private func setUpNavigationBarItems(){
//        let barTitle = "Wishlist"
//        navigationItem.title = barTitle
//        navigationController?.navigationBar.barTintColor = .warmGrey
//        navigationController?.navigationBar.isTranslucent = false
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return name.count
        return wishlistedCoursesArr.count //will increased by events count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WishTableViewCell
        
        cell.courseObj = wishlistedCoursesArr[indexPath.row]
        
//        cell.courseImg.image = imgArr[indexPath.row] as! UIImage
//        cell.courseName.text! = name[indexPath.row] as! String
//        cell.academyName.text! = academyName[indexPath.row] as! String
//        cell.courseDate.text! = date[indexPath.row] as! String
     //   cell.cardDesign.viewWithTag(1) = cardView[indexPath.row] as! DesignCourseList
     //   cell.favBtn.buttonType = favouriteBtn[indexPath.row] as! UIButton
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    
}

extension WishListVC{
    
    private func retriveWishListedCourses(){
        
        guard let uId = Auth.auth().currentUser?.uid else {
            print("cannot find userID")
            return
        }
        
        print("Wishlist")

        let userRef = dbRef!.child("User").child(uId)
        let wishlistRef = userRef.child("WishList")
        let wishCoursesList = wishlistRef.child("Courses").child("courseId")
        wishCoursesList.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children{
                print("childSnap\(child)")
                let snap = child as! DataSnapshot
                
                let courseId = snap.value as! String
                print("WishlistedCoursesIdVC\(courseId)")
                self.wishlistedCoursesIds.append(courseId)
//                self.wishlistedCoursesIds = courseId
//                self.wishlistedCoursesIds += courseId
                print("WishlistedCoursesIdArrayVC\(self.wishlistedCoursesIds)")
                
            }
            self.getCoursesData(coursesIds: self.wishlistedCoursesIds)
        })

        
        
    }
    
    private func getCoursesData(coursesIds : [String]){
        
        let academiesRef = dbRef?.child("Academies")
        academiesRef?.queryLimited(toLast: 10).observe(.value, with: { [weak self] snapshot in
            
            if let academiesList = snapshot.value as? [String : Any]{
                
                let academiesIds = academiesList.keys
                for id in academiesIds{
                    let academy = academiesList[id] as? [String : Any]
                    
                    let academyCoursesList = academy?["courses"] as? [String : Any]
                    print("coursesNode\(academyCoursesList)")

                    for courseId in coursesIds{
                        
                        let course = academyCoursesList![courseId] as? [String : Any ]
                        //                    print("SingleCourseData\(String(describing: course))")
                        var courseInformation = course!["information"] as? [String : Any]
                        courseInformation!["key"] = courseId
                        //                    print("SingleCourseInformation\(String(describing: courseInformation))") // till here true
                        let courseInfoDict = Course(dictionary: courseInformation!)
                        
                        self?.wishlistedCoursesArr.append(courseInfoDict)
                    //  var courseReview = course?["review"] as? [String : Any]
                        }
                    print("wishlistVCArray\(self?.wishlistedCoursesArr)")
                    
                }
                self!.tableView.reloadData()
            }
            
        })
        
//        for id in wishlistedCoursesIds{
//            dbRef?.child("Academies").queryOrderedByKey().observe(.value, with: { (snapshot) in
//                let courseSnap = snapshot.childSnapshot(forPath: "courses").childSnapshot(forPath: id).childSnapshot(forPath: "information") as! DataSnapshot
//                //child.id
//                print("courseSnapshot\(courseSnap)")
//
//                var courseDict = courseSnap.value as! [String : Any]
//                courseDict["key"] = id
//                let courseInfoDict = Course(dictionary: courseDict)
//                print("courseInfoDictVC\(courseInfoDict)")
//                self.wishlistedCoursesArr.append(courseInfoDict)
//
//            })
//
//            print("WishlistedCoursesArrayVC\(wishlistedCoursesArr)")
//        }
//        self.tableView.reloadData()
        
        
    }
    
}

