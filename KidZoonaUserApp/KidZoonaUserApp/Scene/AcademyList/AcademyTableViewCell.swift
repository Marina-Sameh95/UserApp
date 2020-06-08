//
//  AcademyTableViewCell.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/2/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos

class AcademyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: DesignCourseList!
    
    @IBOutlet weak var academyImage: UIImageView!
    @IBOutlet weak var academyRateView: CosmosView!
    @IBOutlet weak var academyName: UILabel!
    
//    var rate : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCosmosView(defultRateValue: 2.5)
    }

    

}

extension AcademyTableViewCell {
    
//    func setUpCosmosUIView(){
//        rateView.settings.fillMode = .full
//        rateView.didTouchCosmos = {rating in
//            print("rate is\(rating)")
//            self.rate = "\(rating)"
//        }
//    }
    
    func setUpCosmosView(defultRateValue : Double){
        academyRateView.settings.updateOnTouch = false
        academyRateView.settings.totalStars = 5
        academyRateView.settings.fillMode = .precise
        academyRateView.rating = defultRateValue
    }
}
