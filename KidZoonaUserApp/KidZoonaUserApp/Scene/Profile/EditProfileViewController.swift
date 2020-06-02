//
//  EditProfileViewController.swift
//  KidZoonaUserApp
//
//  Created by Marina Sameh on 5/25/20.
//  Copyright © 2020 asmaa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class EditProfileViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var userImageOutLet: UIImageView!
    
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
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = UIColor.lightGray.cgColor
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
 
    @IBAction func uploadPhoto(_ sender: Any) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func saveEditUserInfo(_ sender: Any) {
//        guard let userImg = userImageOutLet.image else { return }
//        guard let uploadImg = userImg.jpegData(compressionQuality: 0.3) else { return }  //compress img
//        let fileName = NSUUID().uuidString  //make file to arange
//
//        let ref = Storage.storage().reference().child("UserProfileImage").child(fileName)
//        ref.putData(uploadImg, metadata: nil) { (metaData, error) in
//            if let error = error {
//                print("failed to uploadImg", error.localizedDescription)
//                return
//            }
//            ref.downloadURL(completion: { (url, error) in
//                if let error = error {
//                    print("failed to uploadImg", error.localizedDescription)
//                    return
//                }
//                guard let profileImagUrl = url?.absoluteString else {
//                    print("something wrong when get url image")
//                    return
//                }
//                print("succefully upload profile image \(profileImagUrl)")
//
//                guard let uid = Auth.auth().currentUser?.uid else {return}
//                let ref = Database.database().reference().child("User").child(uid)
//                let dicValue = ["profileImage": profileImagUrl]
//                ref.updateChildValues(dicValue, withCompletionBlock: { (err, ref) in
//                    if let err = err {
//                        print("Failed to push user image", err.localizedDescription)
//                    }
//
//                    print("Succefully put image")
//                })
//
//
//
//            })
//        }
//    }
}

}
//
//extension EditProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let editImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            userImageOutLet.image = editImage
//        }else if let selectImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            userImageOutLet.image = selectImage
//        }
//       picker.dismiss(animated: true, completion: nil)
//    }
//}

