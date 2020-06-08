//
//  UserReviewCell.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/26/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos

class UserReviewCell: UITableViewCell {
    
//    @IBOutlet weak var cellView: UIView!
    
//    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
//    @IBOutlet weak var overviewRating: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    
    let rating = ["Excllent","Very Good", "Good", "Fair","Weak"]
    
    var rate : Double?
}

extension UserReviewCell{
    
    func setUpCosmosView(){
        rateView.settings.fillMode = .full
        rateView.settings.updateOnTouch = false
        rateView.rating = rate!
    }
    
    private func getUserData(){
        
    }
}
