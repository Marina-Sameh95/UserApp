//
//  AcademyProfileVC.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/26/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import Kingfisher

class AcademyProfileVC: UIViewController {
    
    var currentAcademy : Academy?
    var dbRef : DatabaseReference?
    
//    var academyCourses = [Course]()

    @IBOutlet weak var academyImage: UIImageView!
    @IBOutlet weak var academyName: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView! // to get rating
    @IBOutlet weak var academyLocationLabel: UILabel!
    @IBOutlet weak var getDirectionOfAcademyFromMapBtn: UIButton!
    @IBOutlet weak var academyReviewTableView: UITableView!
    
    var rate : String?
    
    let lineImage: UIImageView = {
        let line = UIImageView()
        line.image = UIImage(named: "line")
        return line
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        academyReviewTableView.delegate = self
        academyReviewTableView.dataSource = self

        
        dbRef = Database.database().reference()
        
        view.backgroundColor  = .whiteTwo
        
        fetchAcademyData()
        
        setUpCosmosUIView()

    }
    
    @IBAction func toAcademyCoursesList(_ sender: Any?) {
        
//        getAcademyCourses(academyId: (currentAcademy?.id)!)
//        performSegue(withIdentifier: "toAcademyCourses", sender: sender)

    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
//        guard let identString = segue.identifier, let identifier = SegueIndentifier(rawValue: identString) else {
//            super.prepare(for: segue, sender: sender)
//            return
//        }
        
//        switch identifier {
//        case .showDetails:
//
//            let courses = academyCourses
//            guard let coursesListVC = segue.destination as? CourseListViewController else {
//                return
//            }
//            coursesListVC.coursesArr = courses as! [Course]
//
//        }
        
        if segue.identifier == "toAcademyCourses" {
            if let coursesListVC = segue.destination as? CourseListViewController {
                coursesListVC.currentAcademy = self.currentAcademy
            }
        }
        
        
//        coursesListVC.coursesArr = academyCourses as! [Course]
        
    }
    
}

extension AcademyProfileVC{
    
//    enum SegueIndentifier : String{
//        case showDetails = "toAcademyCourses"
//    }
    
    private func setUpCosmosUIView(){
        ratingView.settings.fillMode = .full
        ratingView.text = "Rate Us"
        ratingView.didTouchCosmos = {rating in
            
            let userReviewCell = UserReviewCell()
            userReviewCell.rate = rating
            
            print("rate is\(rating)")
            
            self.rate = "\(rating)"
        }
    }
    
    private func fetchAcademyData(){
        academyLocationLabel.text = currentAcademy?.location
        academyName.text = currentAcademy?.name
        
        let url = URL(string: (currentAcademy?.image)!)
        if let imgUrl = url as? URL{
            KingfisherManager.shared.retrieveImage(with: imgUrl as! Resource, options: nil, progressBlock: nil) { (image, error, cache, academyImage) in
                self.academyImage.image = image
                self.academyImage.kf.indicatorType = .activity
            }
        }
    }
    
//    private func getAcademyCourses(academyId : String){
//
//        let academyCoursesRef = dbRef?.child("Academies").child(academyId).child("courses")
//        academyCoursesRef?.queryLimited(toLast: 10).observe(.value, with: { [weak self] snapshot in
//            if let academyCoursesList = snapshot.value as? [String : Any]{
//                print("coursesList\(academyCoursesList)")
//                let coursesIds = academyCoursesList.keys
//                print("coursesKeys\(coursesIds)")
//
//                for courseId in coursesIds{
//                    let course = academyCoursesList[courseId] as? [String : Any ]
//                    print("SingleCourseData\(String(describing: course))")
//                    var courseInformation = course!["information"] as? [String : Any]
//                    courseInformation!["key"] = courseId
//                    print("SingleCourseInformation\(String(describing: courseInformation))") // till here true
//                    let courseInfoDict = Course(dictionary: courseInformation!)
//                    self?.academyCourses.append(courseInfoDict)
//                    print("courses Array\(String(describing: self?.academyCourses))")
//                }
//
//            }
//        })
//
//    }
    
    
//    private func pushRating(){
//        //get currentAcademyID
//        guard let academyRate = rate else {
//            print("Cannot find academy rate")
//            return
//        }
////        guard let userId = Auth.auth().currentUser?.uid else {
////            print("cannot find userId")
////            return
////        }
////
//        let rateDictValue = ["rate" : academyRate]
//        
//        let academiesRef = dbRef?.child("Academies")
//        let academyId = currentAcademy?.id
//        
//        let infoRef = academiesRef?.child(academyId!).child("Information")
//        
//        infoRef?.updateChildValues(rateDictValue, withCompletionBlock: { (error, dbRef) in
//            
//            if let err = error {
//                print("Cannot Push rate Value", err.localizedDescription)
//            }
//            
//            print("Rate pushed Successfully")
//        })
//        
//        currentAcademy?.rate = rate!
//        
//    }
}

////////////////// extension for Academy ReviewTableView

extension AcademyProfileVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! UserReviewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
}
