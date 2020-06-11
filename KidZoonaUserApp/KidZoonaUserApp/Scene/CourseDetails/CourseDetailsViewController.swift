//
//  CourseDetailsViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/24/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import Kingfisher


class CourseDetailsViewController: UIViewController {
    
    var dbRef : DatabaseReference?
    var name: NSArray = []
    var date: NSArray = []
    var rateView: CosmosView!
    var rate : Double?
    var wishlistedCourses = [String]()

    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var courseImg: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var ratingCourse: CosmosView!
    @IBOutlet weak var courseDate: UILabel!
    @IBOutlet weak var courseCost: UILabel!
    @IBOutlet weak var courseDescription: UITextView!
    @IBOutlet weak var courseOffer: UILabel!
    @IBOutlet weak var courseTime: UILabel!
    
    
    var myCourse : Course?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
    //    retriveWishListedCourses()

        reviewTable.delegate = self
        reviewTable.dataSource = self
        
        
        name = ["Ali","Kero","Mark","Mahmoud","Marwan","Asmaa","Marwa","Hager"]
        date = ["1/6/2020", "5/6/2020", "10/6/2020", "12/6/2020","3/6/2020","11/6/2020","14/6/2020","2/6/2020"]


        registerBtn.layer.cornerRadius = 15

        registerBtn.layer.shadowOpacity = 0.25
        registerBtn.layer.shadowRadius = 5
        registerBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
        
    //    setUpCosmosUIView()
        
        courseName.text =   myCourse?.name
        courseDate.text = myCourse?.date
        courseTime.text = myCourse?.time
        courseDescription.text = myCourse?.description
        courseOffer.text = myCourse?.offer
        courseCost.text = myCourse?.price
        
        let url = URL(string: ((myCourse?.image)!))
        if let url = url as? URL{
            KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil){ (image , error, cache, coursename) in
                self.courseImg.image = image
                self.courseImg.kf.indicatorType = .activity
            }
        }
    }
    

    @IBAction func favouriteBtn(_ sender: UIButton) {
        
        if sender.isSelected{
            sender.isSelected = false
            
       //     addCourseToWishlist()

            
        } else {
            sender.isSelected = true
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()!})
    }
    
    
    
    @IBAction func registerCourse(_ sender: Any) {
        
        guard let uId = Auth.auth().currentUser?.uid else {
            print("cannot find userID")
            return
        }
       // let courseValue = ["courseId" : myCourse?.id] as? [String : String]
        
        let userRef = dbRef!.child("User").child(uId)
        let enrollListRef = userRef.child("enrollment")
        let registerCoursesList = enrollListRef.child("Courses").childByAutoId()
        let courseId = registerCoursesList.child(myCourse!.id)
        print("id=\(courseId)")
        
        let alert = UIAlertController(title: "Register Course", message: "Save your register code #course\(randomString(length: 5))", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in }))

        self.present(alert, animated: true, completion: nil)
    }
    
    }
    

extension CourseDetailsViewController : UITableViewDelegate , UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return name.count
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsCell", for: indexPath) as! CourseDetailsCell
            cell.contentView.backgroundColor = UIColor (white: 0.95, alpha: 1)
            cell.reviewRate = [indexPath.row] as? CosmosView
            cell.reviewDate.text = date[indexPath.row] as? String
            cell.userName.text = name[indexPath.row] as? String

            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//extension CourseDetailsViewController{
//
//    private func setUpCosmosUIView(){
//        ratingCourse.settings.fillMode = .full
//        ratingCourse.text = "Rate Us"
//        ratingCourse.didTouchCosmos = {rating in
//
//            let userReviewCell = CourseDetailsCell()
//           userReviewCell.rate = rating
//          print("rate is\(rating)")
//
//           self.rate = rating
//        }
//    }
//
//    private func addCourseToWishlist(){
//
//        guard let uId = Auth.auth().currentUser?.uid else {
//            print("cannot find userID")
//            return
//        }
//
//        wishlistedCourses.append((myCourse?.id)!)
//
//        let wishCourseValue = ["courseId" : wishlistedCourses] as? [String : [String]]
//
//        dbRef = Database.database().reference()
//        let userRef = dbRef!.child("User").child(uId)
//            //            userReviewCell.rate = rating
//        let wishCoursesList = wishlistRef.child("Courses")
//        wishCoursesList.updateChildValues(wishCourseValue!) { (error, dbRef) in
//            if let err = error{
//                print("Filed to update wishlist node / add wishlist course", err.localizedDescription)
//            }else{
//                print("Suessfully updated wishlist branch")
//            }
//        }
//
//    }
//
//    private func retriveWishListedCourses(){
//
//        guard let uId = Auth.auth().currentUser?.uid else {
//            print("cannot find userID")
//            return
//        }
//
//        dbRef = Database.database().reference()
//        let userRef = dbRef!.child("User").child(uId)
//        let wishlistRef = userRef.child("WishList")
//        let wishCoursesList = wishlistRef.child("Courses")
//        wishCoursesList.observeSingleEvent(of: .value, with: { (snapshot) in
//            for child in snapshot.children{
//                let snap = child as! DataSnapshot
//                let courseId = snap.value as! [String]
//                self.wishlistedCourses.append(contentsOf: courseId)
//                print("Course Details")
//                print("WishlistedCoursesId\(courseId)")
//            }
//        })
//
//        print("WishlistedCoursesidArray\(wishlistedCourses)")
//
//
//    }
//


//}
