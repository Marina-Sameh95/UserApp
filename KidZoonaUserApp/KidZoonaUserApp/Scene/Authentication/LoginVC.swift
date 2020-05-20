//
//  LoginVC.swift
//  KidZoonaUserApp
//
//  Created by MacOSSierra on 5/20/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBOutlet weak var signInBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailText.layer.cornerRadius = 15
        emailText.layer.borderWidth = 2
        emailText.layer.borderColor = UIColor.lightGray.cgColor
        
        passwordText.layer.cornerRadius = 15
        passwordText.layer.borderWidth = 2
        passwordText.layer.borderColor = UIColor.lightGray.cgColor
        
        signInBtnOutlet.layer.cornerRadius = 15
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        
    }
    
    @IBAction func forgetPassBtn(_ sender: Any){
        
    }
    
    @IBAction func fbBtn(_ sender: Any) {
        
    }
    
    @IBAction func googleBtn(_ sender: Any) {
        
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
    }
    
}
