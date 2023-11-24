//
//  ProfileVC.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/22/23.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var updateBTN: UIButton!
    @IBOutlet weak var messageLBL: UILabel!
    private let user = AuthenticationManager.shared.getCurrentUser()
    private let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateBTN.isEnabled = false
        self.getUserDetails(user: user)
    }
    
    private func getUserDetails(user : AuthDataResultModel){
        let uID = user.uid
        let email = user.email
        
        self.db.collection("users").document(uID).getDocument { (document, error) in
            if let document = document, document.exists {
                let userData = document.data()
                let name = userData?["name"] as? String ?? ""
                let birthday = userData?["birthday"] as? String ?? ""
                let country = userData?["country"] as? String ?? ""
                self.nameTF.text = name
                self.emailTF.text = email
                self.countryTF.text = country
                self.birthdayTF.text = birthday
                
            } else {
                print("Error getting user document: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    
    @IBAction func textChange(_ sender: UITextField) {
        self.updateBTN.isEnabled = true
    }
    
    @IBAction func updateUserDetails(_ sender: UIButton) {
        
        guard !(self.nameTF.text!).isEmpty, !(self.birthdayTF.text!).isEmpty, !(self.countryTF.text!).isEmpty else{
            self.updateBTN.isEnabled = false
            self.messageLBL.text = "Please Enter Required Details!"
            return
        }
        let userData: [String: Any] = [
            "name": self.nameTF.text ?? "",
            "birthday": self.birthdayTF.text ?? "",
            "country": self.countryTF.text ?? ""
        ]
        self.db.collection("users").document(self.user.uid).setData(userData) { error in
            if let error = error {
                print("Error writing user data to Firestore: \(error.localizedDescription)")
            } else {
                print("User details updated succesfully")
                self.messageLBL.text = "Details Updated Succesfully!"
                self.updateBTN.isEnabled = false
            }
        }
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try AuthenticationManager.shared.signOut()
            self.performSegue(withIdentifier: "profileToLogin", sender: self)
        }catch {
            print("Error: \(error)")
        }
    }
    
    
}

