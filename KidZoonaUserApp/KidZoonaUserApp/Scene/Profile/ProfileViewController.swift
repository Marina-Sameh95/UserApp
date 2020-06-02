//
//  ProfileViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/25/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var myProfile: UIView!
    @IBOutlet weak var activities: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            myProfile.alpha = 1
            activities.alpha = 0
        } else {
            myProfile.alpha = 0
            activities.alpha = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myProfile.alpha = 1
        activities.alpha = 0
    }
    
    fileprivate func retrieveData() {
        let ref :  DatabaseReference!
        ref = Database.database().reference()
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        ref.child("User").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:Any]
            print(value)
        }
        
    }

}
