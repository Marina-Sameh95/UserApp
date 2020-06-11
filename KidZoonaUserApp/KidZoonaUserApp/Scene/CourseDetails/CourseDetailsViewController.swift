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
    var currentCourse : Course?
    var rate : Double?

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

        reviewTable.delegate = self
        reviewTable.dataSource = self

        registerBtn.layer.cornerRadius = 15

        registerBtn.layer.shadowOpacity = 0.25
        registerBtn.layer.shadowRadius = 5
        registerBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        setUpCosmosUIView()
        
        courseName.text =   myCourse?.name
        courseDate.text = myCourse?.date
        courseTime.text = myCourse?.time
        courseDescription.text = myCourse?.description
        courseOffer.text = myCourse?.offer
        courseCost.text = myCourse?.price
        
        let url = URL(string: ((myCourse?.image)!))
        if let url = url as? URL{
            KingfisherManager.shared.retrieveImage(with: url as! Resource, options: nil, progressBlock: nil){ (image , error, cache, coursename) in
                self.courseImg.image = image
                self.courseImg.kf.indicatorType = .activity
            }
        }
    }
    

    @IBAction func favouriteBtn(_ sender: UIButton) {
        
        if sender.isSelected{
            sender.isSelected = false
            
//            addCourseToWishlist()

            
        } else {
            sender.isSelected = true
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CourseDetailsCell", for: indexPath) as! CourseDetailsCell
            cell.contentView.backgroundColor = UIColor (white: 0.95, alpha: 1)

            return cell
        }
}

extension CourseDetailsViewController{
    
    private func setUpCosmosUIView(){
        ratingCourse.settings.fillMode = .full
        ratingCourse.text = "Rate Us"
        ratingCourse.didTouchCosmos = {rating in
            
            let userReviewCell = CourseDetailsCell()
//            userReviewCell.rate = rating
            
            print("rate is\(rating)")
            
            self.rate = rating
        }
    }
    
    private func addCourseToWishlist(){
        
        guard let uId = Auth.auth().currentUser?.uid else {
            print("cannot find userID")
            return
        }
        
        let wishCourseValue = ["courseId" : currentCourse?.id] as? [String : String]
        
        dbRef = Database.database().reference()
        let userRef = dbRef!.child("User").child(uId)
        let wishlistRef = userRef.child("WishList")
        let wishCoursesList = wishlistRef.child("Courses")
        wishCoursesList.updateChildValues(wishCourseValue!) { (error, dbRef) in
            if let err = error{
                print("Filed to update wishlist node / add wishlist course", err.localizedDescription)
            }else{
                print("Suessfully updated wishlist branch")
            }
        }
        
    }
    
    

}
