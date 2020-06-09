//
//  EventViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/22/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

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
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerBtn.layer.cornerRadius = 15
        
        registerBtn.layer.shadowOpacity = 0.25
        registerBtn.layer.shadowRadius = 5
        registerBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
  
  

}
