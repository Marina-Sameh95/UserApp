//
//  WishTableViewCell.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 6/2/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class WishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardDesign: DesignCourseList!
    @IBOutlet weak var courseDate: UILabel!
    @IBOutlet weak var courseImg: UIImageView!
    @IBOutlet weak var academyName: UILabel!
    @IBOutlet weak var favBtn: RoundedBtn!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension WishTableViewCell{
    
    func updateComsmos(){
        
    }
    
}
