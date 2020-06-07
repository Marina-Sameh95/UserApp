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
    
    @IBOutlet weak var academyImg: UIImageView!
    
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var academyName: UILabel!
    
    var rate : String?
    

}

extension AcademyTableViewCell {
    
    func setUpCosmosUIView(){
        rateView.settings.fillMode = .full
        rateView.didTouchCosmos = {rating in
            print("rate is\(rating)")
            self.rate = "\(rating)"
        }
        
    }
}
