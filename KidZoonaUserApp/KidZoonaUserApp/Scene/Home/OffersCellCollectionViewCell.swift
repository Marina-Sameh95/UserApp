//
//  OffersCellCollectionViewCell.swift
//  KidZoonaUserApp
//
//  Created by MacOSSierra on 5/29/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class OffersCellCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var offerImageInOffersCollection: UIImageView!
    
    
    @IBOutlet weak var courseNameInOffersCollection: UILabel!
    
    
    @IBOutlet weak var courseDiscountInOffersCollection: UILabel!
    
    
    @IBOutlet weak var favoriteBtnInOffersCollection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        offerImageInOffersCollection.layer.cornerRadius = 35
    }
    
    @IBAction func favoriteBtnInOffersCollAction(_ sender: Any) {
        
        print("1 2 3")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("User").child(uid).child("WishList")
        let wishListValue = ["CourseId" : "123"]
        ref.updateChildValues(wishListValue, withCompletionBlock: { (error, ref ) in
            if let error = error {
                print("failed to update/push data in Database", error.localizedDescription)
            }else{
                print("suessfully update Data in DataBase")
            }
        })
    }
    
    
}
