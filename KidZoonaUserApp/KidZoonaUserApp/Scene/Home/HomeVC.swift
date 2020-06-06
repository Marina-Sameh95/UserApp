//
//  HomeVC.swift
//  KidZoonaUserApp
//
//  Created by MacOSSierra on 5/20/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeVC: UIViewController {

    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    
    @IBOutlet weak var offersCollectionView: UICollectionView!
    
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    
    //array of Offers still static array
    let arrayTest = ["Offers", "Music", "Drawing", "Robotics", "Chess", "Science"]
    
    
    //array of (course`s image & name & discount) offers will come from count of courses in courses list -> child offer in it
    
    ///////// will change after Database /////////
    var arrayOfNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    //array of (event`s image & name) will come from count of events in events list -> child in it
    
    ////////////////// will change after Database  ////////
    var arrayOfEventsNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 37/255 , green: 128/255 , blue: 219/255 , alpha: 1)
        
        retrieveData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Home"

    }
    

}


//extension of three Collection Views in HomeVC

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return arrayTest.count
        }else if collectionView == offersCollectionView {
            return arrayOfNames.count
        }else{
            return arrayOfEventsNames.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? headerCollectionViewCell
            
            cell?.titleOfCatagories.text = arrayTest[indexPath.row]
            
            return cell!
            
        }else if collectionView == offersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCell", for: indexPath) as? OffersCellCollectionViewCell
            // IMAGE ... come from count of courses in courses list -> image child offer in it
            cell?.courseNameInOffersCollection.text = arrayOfNames[indexPath.row]
            // DISCOUNT ... come from count of courses in courses list -> discount child offer in it
            
            return cell!
            
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCellCollectionViewCell
            // IMAGE & eventName ... come from count of Events in events list -> image child offer in it
            cell?.eventNameInEventCollection.text = arrayOfEventsNames[indexPath.row]
            return cell!
            
        }

    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == eventsCollectionView{
            let eventView = UIStoryboard(name: "Event", bundle: nil).instantiateViewController(withIdentifier: "EventViewController")
            
            self.navigationController?.pushViewController(eventView, animated: true)
        }
    }
    
}

//extension HomeVC {
//    fileprivate func retrieveData() {
//        let ref :  DatabaseReference!
//        ref = Database.database().reference()
//
//        //guard let userId = Auth.auth().currentUser?.uid else {return}
//        ref.child("Academies").observe(.value, with: { (snapshot) in
//            
//            
//            snapshot.children.forEach({ (data) in
//               // print(data)
//                let snap = data as! DataSnapshot
//                let dic = snap.value as! [String:Any]
//                let event = dic["Events"] as? Any
//                
////                let test = Test(dic: event as! [String : Any])
////                print("name: \(test.name)")
//                print(event)
//            })
//            
//            
////            if let dic = snapshot.value as? [String:Any]{
////                print(dic)
////
////                let test = Test(dic: dic)
////
////                print("events: \(test.events)")
////            }
//            
//            
//            
//        }, withCancel: nil)
//
//         
//
//    
//
//    
//    }
//}
//
//class Test {
//    
//    var name: String
//    var location: String
//  
//    
//    init(dic: [String:Any]){
//        self.name = dic["name"] as? String ?? ""
//        self.location = dic["location"] as? String ?? ""
//    }
//    
//}
