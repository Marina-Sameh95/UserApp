//
//  SignUpVC.swift
//  KidZoonaUserApp
//
//  Created by MacOSSierra on 5/20/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var firstNameTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var emailRegTxt: UITextField!
    
    @IBOutlet weak var passRegTxt: UITextField!
    
    @IBOutlet weak var passRegSecondTxt: UITextField!
    
    @IBOutlet weak var signUpBtnOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegView()
        
    }
    
    fileprivate func setupRegView(){
        firstNameTxt.layer.cornerRadius = 15
        firstNameTxt.layer.borderWidth = 1
        firstNameTxt.layer.borderColor = UIColor.lightGray.cgColor
        
        lastNameTxt.layer.cornerRadius = 15
        lastNameTxt.layer.borderWidth = 1
        lastNameTxt.layer.borderColor = UIColor.lightGray.cgColor
        
        emailRegTxt.layer.cornerRadius = 15
        emailRegTxt.layer.borderWidth = 1
        emailRegTxt.layer.borderColor = UIColor.lightGray.cgColor
        
        passRegTxt.layer.cornerRadius = 15
        passRegTxt.layer.borderWidth = 1
        passRegTxt.layer.borderColor = UIColor.lightGray.cgColor
        
        passRegSecondTxt.layer.cornerRadius = 15
        passRegSecondTxt.layer.borderWidth = 1
        passRegSecondTxt.layer.borderColor = UIColor.lightGray.cgColor
        
        signUpBtnOutlet.layer.cornerRadius = 15
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
    }
    
    @IBAction func fbRegBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func googleRegBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func logInRegBtn(_ sender: Any) {
        
    }
    

}
