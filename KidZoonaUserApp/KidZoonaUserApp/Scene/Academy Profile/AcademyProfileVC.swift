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

class AcademyProfileVC: UIViewController {
    
    var currentAcademy : Academy?
    var dbRef : DatabaseReference?
    
    ///////////////////@IBOutlet weak var collectionView: UICollectionView!
    ///////////////////@IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var academyImage: UIImageView!
    @IBOutlet weak var AcademyName: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView! // to get rating
    @IBOutlet weak var academyLocationLbl: UILabel!
    @IBOutlet weak var getDirectionOfAcademyFromMapBtn: UIButton!
    @IBOutlet weak var academyReviewTableView: UITableView!
    
    /////////////////@IBOutlet weak var tableHeaderView: UIView!
    
    var rate : String?
    ///////////////////////// de elsor eli kant btt3rad fe el collection view w b2a image bs fa shliha lw msh m7tagaha
    let imgs = [
        UIImage(named: "img_1"),
        UIImage(named: "img_2"),
        UIImage(named: "img_3"),
        UIImage(named: "swim_4")
    ]// data source
    ////////////////////////
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let lineImage: UIImageView = {
        let line = UIImageView()
        line.image = UIImage(named: "line")
        return line
    }()
    
    var currentIndex = 0 //current page on view controll
    
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        academyReviewTableView.delegate = self
        academyReviewTableView.dataSource = self
        
//        setUpNavigationBarItems()
//        setUpTableView()
        
        dbRef = Database.database().reference()
        
        view.backgroundColor  = .whiteTwo
        
        //////////////////////pageControl.numberOfPages = imgs.count
        
        fetchAcademyData()
        
//        setUpCosmosUIView()
        
//        startTimer()
    }
    
//    private func setUpTableView(){
//        tableHeaderView.backgroundColor = .whiteThree
//        tableHeaderView.addSubview(lineImage)
//        tableHeaderView.addSubview(headerLabel)
//
//    }
//
//    private func setUpNavigationBarItems(){
//        let barTitle = "Learn Academy"
//        navigationItem.title = barTitle
//        navigationController?.navigationBar.barTintColor = .warmGrey
//        navigationController?.navigationBar.isTranslucent = false
//
//    }
    
//    private func startTimer(){
//        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//    }
//
//    @objc func timerAction(){
//
//        let desiredScrollPosition = (currentIndex < imgs.count - 1 ) ? currentIndex + 1 : 0
//
//        collectionView.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//////////////////////////////////////// da el collection View ely atmsa7 w b2a image w7da w ms7t el slider Cell ViewController bt3ha

//extension AcademyProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imgs.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
//
//        cell.img = imgs[indexPath.item]
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
//
//        pageControl.currentPage = currentIndex
//    }
//}
/////////////////////////////////////////////////////

extension AcademyProfileVC{
    
    private func setUpCosmosUIView(){
        ratingView.settings.fillMode = .full
        ratingView.didTouchCosmos = {rating in
            
            let userReviewCell = UserReviewCell()
            userReviewCell.rate = rating
            
            print("rate is\(rating)")
            
            self.rate = "\(rating)"
        }
    }
    
    private func fetchAcademyData(){
        academyLocationLbl.text = currentAcademy?.location
    }
    
    
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
