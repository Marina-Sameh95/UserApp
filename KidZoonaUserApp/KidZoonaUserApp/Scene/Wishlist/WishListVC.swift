//
//  WishListVC.swift
//  KidZoonaUserApp
//
//  Created by Hagar Diab on 5/27/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class WishListVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpNavigationBarItems()
        
    }
    
    private func setUpNavigationBarItems(){
        let barTitle = "Wishlist"
        navigationItem.title = barTitle
        navigationController?.navigationBar.barTintColor = .warmGrey
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

