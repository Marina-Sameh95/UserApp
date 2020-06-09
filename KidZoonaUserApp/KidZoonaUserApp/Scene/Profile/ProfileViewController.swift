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
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var myProfile: UIView!
    @IBOutlet weak var activities: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var events: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData()
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            myProfile.alpha = 1
            activities.alpha = 0
            events.alpha = 0
        } else if sender.selectedSegmentIndex == 1{
            myProfile.alpha = 0
            activities.alpha = 1
            events.alpha = 0
        } else{
            myProfile.alpha = 0
            activities.alpha = 0
            events.alpha = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myProfile.alpha = 1
        activities.alpha = 0
        events.alpha = 0
    }
    
    var userData: UserData?

    
    fileprivate func retrieveData() {
    
      let ref = Database.database().reference()
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        ref.child("User").child(userId).child("Information").observeSingleEvent(of: .value) { (snapshot) in
            
            
            guard let dic = snapshot.value as? [String: Any] else {return}
            
            let user = UserData(uid: userId, dictionary: dic)
            self.userName.text = user.fullName
            self.userData = user
          
            
            if let photoURL = self.userData?.userImage{
                KingfisherManager.shared.retrieveImage(with: photoURL as! Resource, options: nil, progressBlock: nil, completionHandler: { (image, err, chach, photoURL) in
                    <#code#>
                })
            }
            
            
//            if let photoURL = self.userData?.userImage{
//                 print("PhotoUrl: \(photoURL)")
//                //Download Photo
//                URLSession.shared.dataTask(with: URL(string: photoURL)!) { (data, response, err) in
//                    if let err = err {
//                        print("Failed to download user image", err)
//                        return
//                    }
//                    if let data = data , let image = UIImage(data: data){
//                        DispatchQueue.main.async{
//                            self.userImage.image = image
//                        }
//                    }
//                    }.resume()
//            }
         
        }
    }



    
    
}
