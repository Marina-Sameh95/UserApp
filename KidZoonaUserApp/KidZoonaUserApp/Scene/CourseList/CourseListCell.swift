//
//  CourseListCell.swift
//  KidZoonaUserApp
//
//  Created by MacOSSierra on 6/4/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos

class CourseListCell: UITableViewCell {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var coursePriceLabel: UILabel!
    @IBOutlet weak var cosmosRateView: CosmosView!
    @IBOutlet weak var courseImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCosmosView(defultRateValue: 2.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CourseListCell{
    
    func setUpCosmosView(defultRateValue : Double){
        cosmosRateView.settings.updateOnTouch = false
        cosmosRateView.settings.totalStars = 5
        cosmosRateView.settings.fillMode = .precise
        cosmosRateView.rating = defultRateValue
    }
}

