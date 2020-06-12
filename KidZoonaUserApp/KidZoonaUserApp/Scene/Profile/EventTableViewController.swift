//
//  EventTableViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/6/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EventTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var name: NSArray = []
    var imgArr: NSArray = []
    var academyName: NSArray = []
    var date: NSArray = []
    
    var eventArr = [String]()
    var allEventKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getEventKeys()
        retriveDataFromAcadmeies()
        
    }
    
    fileprivate func getEventKeys (){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("User").child(uid).child("enrollment").child("event").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // guard let userDic = snapshot.value as? [String:Any] else {return}
            snapshot.children.forEach { (data) in
                let snap = data as! DataSnapshot
                let dict = snap.value as! [String: Any]
                let eventId = dict["eventId"] as? String
                print("eventId \(eventId)")
                self.eventArr.append(eventId ?? "nil")
                self.tableView.reloadData()
            }
            
        }) { (err) in
            print("Failed to fetch user post", err)
        }
    }
    
    fileprivate func retriveDataFromAcadmeies(){
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
    
    
    //    fileprivate func retriveDataFromAcadmeies(){
    //
    //
    ////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    ////            print("eventArr  :  \(self.eventArr.count)")
    ////               print("eventArr  :  \(self.eventArr)")
    ////        }
    //        let ref = Database.database().reference().child("Academies")
    //        ref.observe( .value, with: {  snapshot in
    //            if let academiesList = snapshot.value as? [String : Any]{
    //                let academiesIds = academiesList.keys
    //                //  print("AllKey\(academiesIds)")
    //                for id in academiesIds{
    //                    guard let academyUid = academiesList[id] as? [String : Any] else {return}
    //                    guard let event = academyUid["Events"] as? [String : Any] else {return}
    //                    let eventsKey = event.keys
    //                    for key in eventsKey{
    //                        self.allEventKeys.append(key)
    //                    }
    //
    //                    print("all Key of Events: \(self.allEventKeys)")
    //
    //                    //event?["key"] = id  // Hena mask IDs kol Academy lw7dha
    //                    //var event = Event(dictionary: information!) // hena d5lt goa el event root eli t7t kol academy
    //                    //print("event key : \(event?.keys)") // hena mska kol el IDs bt3t el events bs kol events for one academy in one array
    //
    ////                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    ////                        for key in self.eventArr{
    ////                            print("my Keys: \(key)")
    ////                            guard let dataOfEverRegKeys = event[key] as? [String : Any] else {return}
    ////                            print("ya rab tb2a hia de : \(dataOfEverRegKeys)")
    ////                            let event = Event(dictionary: dataOfEverRegKeys)
    ////                            print("eventName \(event.name)")
    ////
    ////                        }
    //                   // }
    //
    //                }
    //
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    //                    print("eventArr  :  \(self.eventArr.count)")
    //                    print("eventArr  :  \(self.eventArr)")
    //                }
    //            }
    //
    //        })
    //
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventSegmentTableViewCell
        
        // cell.eventImg.image = imgArr[indexPath.row] as! UIImage
        cell.eventName.text! = eventArr[indexPath.row]
        //  cell.academyName.text! = eventArr[indexPath.row]
        //  cell.eventDate.text! = date[indexPath.row] as! String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("event Key: \(eventArr[indexPath.row])")
    }
    
}
