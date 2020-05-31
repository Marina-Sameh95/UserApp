//
//  SignUpVC.swift
//  KidZoonaUserApp
//
//  Created by MacOSSierra on 5/20/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

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
        
        self.navigationController?.isNavigationBarHidden = true
        
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
        
        guard let email = emailRegTxt.text, email.count > 0 else {
            print("please enter your Email Address")
            return
        }
        guard let pass = passRegTxt.text, pass.count > 0 else{
            print("please enter your Password")
            return
        }
        
        // Register the User to Firebase
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if let error = error{
                print("failed to sign up firebase", error.localizedDescription)
                return
            } else {
                print("Successfully SignUp")
            }
        }
    }
    
    
    
    @IBAction func logInRegBtn(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    

}
