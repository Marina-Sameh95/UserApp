//
//  UserDataprofile.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/2/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import Foundation

class UserData {
    var fullName: String
    var email : String
  //  var userImage : String
    
    init(dictionary: [String: Any]){
        self.fullName = dictionary["UserName"] as! String
        self.email = dictionary["userEmail"] as! String
     //   self.userImage = dictionary["profileImage"] as! String
    }
}
