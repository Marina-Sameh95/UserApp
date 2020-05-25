//
//  EditProfileViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/25/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userName.layer.cornerRadius = 15
        userName.layer.borderWidth = 1
        userName.layer.borderColor = UIColor.lightGray.cgColor
        
        email.layer.cornerRadius = 15
        email.layer.borderWidth = 1
        email.layer.borderColor = UIColor.lightGray.cgColor
        
        birthDate.layer.cornerRadius = 15
        birthDate.layer.borderWidth = 1
        birthDate.layer.borderColor = UIColor.lightGray.cgColor
        
        saveBtn.layer.cornerRadius = 15
        saveBtn.layer.borderWidth = 2
        saveBtn.layer.borderColor = UIColor.blue.cgColor
        
        createDatePicker()
    }
    
    @IBAction func male(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    
    @IBAction func female(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    func createDatePicker(){
        birthDate.textAlignment = .center
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        birthDate.inputAccessoryView = toolbar
        birthDate.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
   @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
    
        birthDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
