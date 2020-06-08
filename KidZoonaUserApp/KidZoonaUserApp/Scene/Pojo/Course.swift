//
//  Course.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 6/7/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import Foundation

class Course {
    var name : String
    var email : String
    var location : String
    var papers : String
    var image : String
    var password : String
    var phone : String
//    var rate : String
    
    init(dictionary: [String: Any]){
        self.name = dictionary["name"] as! String
        self.email = dictionary["email"] as! String
        self.location = dictionary["location"] as! String
        self.papers = dictionary["papers"] as! String
        self.image = dictionary["image"] as! String
        self.phone = dictionary["phone"] as! String
        self.password = dictionary["password"] as! String
//        self.rate = dictionary["rate"] as! String
    }
}
