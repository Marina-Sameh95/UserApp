//
//  SliderCell.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/26/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    @IBOutlet weak var heartBtn: UIButton! {
        didSet{
            heartBtn.layer.cornerRadius = heartBtn.frame.size.width / 2
            heartBtn.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var imgView: UIImageView!
    
    var img : UIImage! {
        didSet{
            imgView.image = img
        }
    }// property observer
    
//    func makeItCircle(_ object : AnyObject) {
//        object.layer.cornerRadius = object.frame.size.width / 2
//        object.layer.masksToBounds = true
//    }
    
}
