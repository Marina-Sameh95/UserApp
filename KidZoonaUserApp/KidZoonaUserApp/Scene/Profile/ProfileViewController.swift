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
    

    var userData = [UserData]()
    
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
        ref.child("User").child(userId).child("Information").observeSingleEvent(of: .value) { (snapshot) in
            
            
            guard let value = snapshot.value as? [String: Any] else {return}
            let dataUser = UserData(dictionary: value)
            self.userData.append(dataUser)
            guard let username = self.userData.first?.fullName else {return}
            self.userName.text = username
//            guard let imageUrl = self.userData.first?.userImage else {return}
//            print(imageUrl)
            
            
            //Download Image
            //            URLSession.shared.dataTask(with: URL(string: imageUrl)!, completionHandler: { (data, response, err) in
            //                if let err = err {
            //                    print("Failed to download data ", err)
            //                    return
            //                }else {
            //                    if let data = data , let image = UIImage(data: data){
            //                        DispatchQueue.main.async {
            //                            self.userImage.image = image
            //                        }
            //                    }
            //                }
            //
            //            })
            
            
            //            self.userImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "icon -time"))
            
            //            for (k,v) in dic{
            //                print("key: \(k), value: \(v)")
            //                var value = v
            //                print("\(value)")
            //            }
            
        }
        
    }



    
    
}
