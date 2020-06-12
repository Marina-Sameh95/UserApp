//
//  EventViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/22/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher


class EventViewController: UIViewController {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var eventDirectionOnMap: UIButton!
    @IBOutlet weak var eventCost: UILabel!
    @IBOutlet weak var eventRegisteredPeople: UILabel!
    
    @IBOutlet weak var availablePlacesInEvent: UILabel!
    
    @IBOutlet weak var desciptionTextOfEvent: UITextView!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    var name: String = ""
    var date: String = ""
    var time: String = ""
    var price: String = ""
    var descrption: String = ""
    var image: String = ""
    var coach: String = ""
    var location: String = ""
    var availableSeats: String = ""
    
    var eventKey: String = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerBtn.layer.cornerRadius = 15
        
        registerBtn.layer.shadowOpacity = 0.25
        registerBtn.layer.shadowRadius = 5
        registerBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
        setupView()
    }
    
    fileprivate func setupView(){
        
        let imageUrl = URL(string: image)
        if let url = imageUrl{
            KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil){ (image , error, cache, coursename) in
                self.eventImage.image = image
                self.eventImage.kf.indicatorType = .activity
                
            }
        }
        
        eventName.text = name
        eventDate.text = date
        eventTime.text = time
        eventAddress.text = location
        availablePlacesInEvent.text = availableSeats
        eventCost.text = price
        desciptionTextOfEvent.text = descrption
    }
    
    fileprivate func createEvent() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("User").child(uid).child("enrollment").child("event").childByAutoId()
        let wishListValue = ["eventId" : eventKey]
        
        ref.setValue(wishListValue) { (err, ref) in
            if let error = err {
                print("failed to update/push data in Database", error.localizedDescription)
            }else{
                print("suessfully update Data in DataBase")
                let eventTableView = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "EventTableViewController") as!
                EventTableViewController
                self.navigationController?.pushViewController(eventTableView, animated: true)
            }
        }
        
        //        ref.updateChildValues(wishListValue, withCompletionBlock: { (error, ref ) in
        //            if let error = error {
        //                print("failed to update/push data in Database", error.localizedDescription)
        //            }else{
        //                print("suessfully update Data in DataBase")
        //            }
        //        })
    }
    
    
    @IBAction func registerBtn(_ sender: Any) {
         self.createEvent()
    }
    
  

}
