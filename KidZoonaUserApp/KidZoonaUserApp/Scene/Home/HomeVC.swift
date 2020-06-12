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
import Kingfisher

class HomeVC: UIViewController {

    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    
    
    @IBOutlet weak var offersCollectionView: UICollectionView!
    
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    var events = [Event]()
    var eventKey =  [String]()
    
    //array of Offers still static array
    let arrayTest = ["Offers", "Music", "Drawing", "Robotics", "Chess", "Science"]
    
    
    //array of (course`s image & name & discount) offers will come from count of courses in courses list -> child offer in it
    
    ///////// will change after Database /////////
    var arrayOfNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    //array of (event`s image & name) will come from count of events in events list -> child in it
    
    ////////////////// will change after Database  ////////
    var arrayOfEventsNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var arrayEventsNames = [String]()
    
    
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
        getAcademiesData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Home"
        
    }
    fileprivate func setupCollectionViewLayout(){
        let layoutHeader = self.headerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutHeader.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        headerCollectionView.showsHorizontalScrollIndicator = false
        
        let layoutOffers = self.offersCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutOffers.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        offersCollectionView.showsHorizontalScrollIndicator = false
        
        let layoutEvent = self.eventsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutEvent.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layoutEvent.minimumLineSpacing = 5
        eventsCollectionView.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func retrieveData() {
        let ref :  DatabaseReference!
        ref = Database.database().reference()
        
        //guard let userId = Auth.auth().currentUser?.uid else {return}
        ref.child("Academies").observe(.value, with: { (snapshot) in
            
            
            snapshot.children.forEach({ (data) in
                // print(data)
                let snap = data as! DataSnapshot
                snap.children.forEach{ (dataEv) in
                    let snap2 = data as! DataSnapshot
                    // print(snap2)
                    snap2.children.forEach({ (data2) in
                        let snap = data2 as! DataSnapshot
                        print("name of snap :\(snap)")
                        let dic = snap.value as! [String : Any]
                        let comment = dic["name"] as? String
                        print("name of academy :\(comment)")
                    })
                    
                }
                
            })
            
        }, withCancel: nil)
        
    }
    
    fileprivate func getAcademiesData(){
        
        let ref = Database.database().reference()
        let academiesRef = ref.child("Academies")
        academiesRef.observe( .value, with: {  snapshot in
            if let academiesList = snapshot.value as? [String : Any]{
                let academiesIds = academiesList.keys
                print("AllKey\(academiesIds)")
                for id in academiesIds{
                    let academy = academiesList[id] as? [String : Any]
                    let event = academy?["Events"] as? [String : Any]
                    //event?["key"] = id  // Hena mask IDs kol Academy lw7dha
                    //var event = Event(dictionary: information!) // hena d5lt goa el event root eli t7t kol academy
                    //print("event key : \(event?.keys)") // hena mska kol el IDs bt3t el events bs kol events for one academy in one array
                    let eventsIds = event?.keys
                    //  print("events key : \(eventsIds)")
                    
                    for key in eventsIds!{
                        print("keyyyy : \(key)")
                        self.eventKey.append(key)
                        /// hena kol key event lw7doooooooo a5eraaaaaaaaaan ^_^
                        let asmaa = event?[key] as? [String : Any]
                        print("ya rab tb2a hia de : \(asmaa)")
                        //   let eventName2 = asmaa?["name"]
                        //     print("isa hia de: \(eventName2)")
                        let event = Event(dictionary: asmaa!)
                        self.events.append(event)
                        // self.eventName.append(eventName2 as! String)
                        print("evntsNameConnt: \(self.events.count)")
                        self.eventsCollectionView.reloadData()
                        let eventImage = asmaa?["image"]
                        print("sorha URLs b2a kda yala 3iza anam : \(eventImage)")
                    }
                    
                }
            }
            
        })
    }
    
}


//extension of three Collection Views in HomeVC
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            
            return arrayTest.count
        }else if collectionView == offersCollectionView {
            return arrayOfNames.count
        }else {
            print("Event name count in number of item:  \(events.count)")
            return events.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! headerCollectionViewCell
            
            cell.titleOfCatagories.text = arrayTest[indexPath.row]
            
            cell.layer.cornerRadius = 40
            cell.layer.borderWidth = 1.0
            
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.masksToBounds = true
            
            
            return cell
            
        }else if collectionView == offersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCell", for: indexPath) as! OffersCellCollectionViewCell
            // IMAGE ... come from count of courses in courses list -> image child offer in it
            cell.courseNameInOffersCollection.text = arrayOfNames[indexPath.row]
            // DISCOUNT ... come from count of courses in courses list -> discount child offer in it
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCellCollectionViewCell
            // IMAGE & eventName ... come from count of Events in events list -> image child offer in it
            cell.eventNameInEventCollection.text = events[indexPath.row].name
            let imagUrlArray = self.events[indexPath.row].image
            print("imageArray \(imagUrlArray)")
            let photoURL = URL(string: (imagUrlArray))
            // print("UserImage : \(photoURL)")
            
            if let url = photoURL{
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil){ (image , error, cache, coursename) in
                    cell.eventImageInEventCollection.image = image
                    cell.eventImageInEventCollection.kf.indicatorType = .activity
                    
                }
            }
            
            
            return cell
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == headerCollectionView{
            print("eventName: \(events[indexPath.row].name)")
            print("Count Event name: \(events.count)")
        }
        
        if collectionView == eventsCollectionView{
            let eventView = UIStoryboard(name: "Event", bundle: nil).instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            
            eventView.image = events[indexPath.row].image
            eventView.name = events[indexPath.row].name
            eventView.date = events[indexPath.row].date
            eventView.time = events[indexPath.row].time
            eventView.price = events[indexPath.row].price
            eventView.descrption = events[indexPath.row].descrption
            eventView.location = events[indexPath.row].location
            eventView.availableSeats = events[indexPath.row].availableSeats
            
            eventView.eventKey = eventKey[indexPath.row]
            
            
            
            self.navigationController?.pushViewController(eventView, animated: true)
        }
    }
    
}

//extension HomeVC {
//    fileprivate func retrieveData() {
//        var AcademyObjList = [Academy]()
//        let query = Database.database().reference().child("Academies").queryLimited(toLast: 10)
//        _ = query.observe(.value, with: { [weak self] snapshot in
//            if let academyList = snapshot.value as? [String:Any]{
//                let academyids = academyList.keys
//                for id in academyids{
//                    let academy = academyList[id] as? [String:Any]
//                    print("academy : \(academy)")
////                    let Events = academy?["Events"] as? [String:Any]
////                    let eventIds = Events?.keys
////                    let singleEvent = Events[]
////                    print("Information\(Events)")
//                }
//                //                    let academyObj = Academy(email: <#T##String#>, image: <#T##String#>, location: <#T##String#>, name: <#T##String#>, papers: <#T##String#>, password: <#T##String#>, phone: <#T##String#>)
//                //                    let events = academy?["Events"] as! [String:Any]
//                //                    let eventids = events.keys
//                //                    print("event id =\(eventids)")
//
//
//                //                    let academyObj = Academy(
//                //                    AcademyObjList.append(academyObj)
//                //  print("academy=\(academy)")
//
//                //  print("event=\(event)")
//
//
//
//                // print("academy=\(academy)")
//                //  }
//                // print("obj list = \(AcademyObjList[0])")
//
//                //                let firstID = academyids[0]
//            }
//        })
//    }
//}








//extension HomeVC {
//
//
//    fileprivate func retrieveEventsData(){
//        let ref = Database.database().reference().child("Academies")
//        ref.observe(.value, with: { [weak self] snapshot in
//
//            if let academiesList = snapshot.value as? [String : Any]{
//                let academiesIds = academiesList.keys
//                print("keys of Academies\(academiesIds)")
//                for id in academiesIds{
//                    let academy = academiesList[id] as? [String : Any]
//
//
//                    print("academy : \(academy)")
//
//                    var event = academy?["Events"] as? [String : Any]
//                    print("events : \(event)")
//                    //event?["key"] = id  // Hena mask IDs kol Academy lw7dha
//                    //var event = Event(dictionary: information!) // hena d5lt goa el event root eli t7t kol academy
//                    print("event key : \(event?.keys)") // hena mska kol el IDs bt3t el events bs kol events for one academy in one array
//
//                    let eventsIds = event?.keys
//                    print("events key : \(eventsIds)")
//
//                    for key in eventsIds!{
//                        print("keyyyy : \(key)")  /// hena kol key event lw7doooooooo a5eraaaaaaaaaan ^_^
//                        let allEvents = event?[key] as? [String : Any]
//                        print("ya rab tb2a hia de : \(allEvents)") // de data kalma bt3t event wa7ed
//                        var eventName2 = allEvents?["name"]
//                        print("isa hia de: \(eventName2)")
//                        self!.arrayEventsNames.append(eventName2 as! String)
//                        var eventImage = allEvents?["image"]
//                        print("sorha URLs b2a kda yala 3iza anam : \(eventImage)")
//
//                    }
//
//
//
//
//                    //self.tableView.reloadData()
//
//                   // print("SingleAcademy\(String(describing: academy))") //hena Events :{ y3ny mask kol el events
//
//
//
//                    //print("SingleInfoDictonary\(String(describing: information))") // hena msk awl event fe kol academy
//                    //print("nameOfEvents\(id)")
//                     //print("nameOfEvents :  \(information.name)")
//
//
//
//                }
//            }
//
//        })
//    }
//}

//    fileprivate func retrieveData() {
//        let ref :  DatabaseReference!
//        ref = Database.database().reference()
//
//        //guard let userId = Auth.auth().currentUser?.uid else {return}
//        ref.child("Academies").observe(.value, with: { (snapshot) in
//
//
//            snapshot.children.forEach({ (data) in
//                // print(data)
//                let snap = data as! DataSnapshot
//                snap.children.forEach{ (dataEv) in
//                    let snap2 = data as! DataSnapshot
//                    // print(snap2)
//                    snap2.children.forEach({ (data2) in
//                        let snap = data2 as! DataSnapshot
//                        print("name of snap :\(snap)")
//                        let dic = snap.value as! [String : Any]
//                        let comment = dic["name"] as? String
//                        print("name of academy :\(comment)")
//                    })
//
//                }
////                if let dic = snap.value as? [String: Any]{
////                    print(dic)
////                    //                    for id in dic {
////                    //                        print("academyId : \(id.key)")
////                    //                    }
////
////                    let eventsIds = dic.keys
////                    print("IDs : \(eventsIds)")
////                    let id : [String : Any]
////                    for id in eventsIds{
////                        //let event = dic[id] as? [String : Any]
////                        //                    let test = Test(dic: id as! [String : Any])
////                        //                    print("name: \(test.name)")
////
////                        //                print("branches : \(id)")
////
////                        //                    print ("asmaa : \(eventsIds[id])")
////                        //                    print("asmaa2 : \(eventId)")
////                        //                    let rootsofEvenets = id
////
////                    }
////                }
////
//                //                let event = dic["Events"] as? Any
//                //
//                //                let test = Test(dic: event as! [String : Any])
//                //                print("name: \(test.name)")
//
//                //print(event)
//            })
//
//
//            //            if let dic = snapshot.value as? [String:Any]{
//            //                print(dic)
//            //
//            //                let test = Test(dic: dic)
//            //
//            //                print("events: \(test.events)")
//            //            }
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
