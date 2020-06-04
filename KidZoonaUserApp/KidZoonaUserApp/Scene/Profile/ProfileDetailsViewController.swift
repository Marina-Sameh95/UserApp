//
//  ProfileDetailsViewController.swift
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

class ProfileDetailsViewController: UIViewController {

    @IBOutlet weak var editBtn: UIButton!
        
    @IBOutlet weak var userEmailDetails: UILabel!
    
     var userData = [UserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editBtn.layer.cornerRadius = 15
        
     retrieveData()
    }
    
    fileprivate func retrieveData() {
        let ref :  DatabaseReference!
        ref = Database.database().reference()
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        ref.child("User").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            
            
            guard let value = snapshot.value as? [String: Any] else {return}
            let dataUser = UserData(dictionary: value)
            self.userData.append(dataUser)
//            guard let imageUrl = self.userData.first?.userImage else {return}
//            print(imageUrl)
            
            guard let useremail = self.userData.first?.email else {return}
            self.userEmailDetails.text = useremail
            
        }
        
    }

  

}
