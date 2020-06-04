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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
