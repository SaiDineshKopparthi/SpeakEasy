//
//  NewAccountVC.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/19/23.
//

import UIKit
import Firebase

class NewAccountVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var birthdayTF: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var checkPasswordTF: UITextField!
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var createBTN: UIButton!
    
    private let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.text = ""
        self.passwordTF.text = ""
        self.messageLBL.text = ""
        self.createBTN.isEnabled = false
    }
    
    @IBAction func checkPasswordStart(_ sender: UITextField) {
        guard let password = sender.text, !(self.checkPasswordTF.text!).isEmpty, password == self.checkPasswordTF.text else{
            self.messageLBL.text = "Password should match!"
            self.createBTN.isEnabled = false
            return
        }
        self.messageLBL.text = ""
        self.createBTN.isEnabled = true
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        guard let password = sender.text, !password.isEmpty, password == self.passwordTF.text else{
            self.messageLBL.text = "Password should match!"
            self.createBTN.isEnabled = false
            return
        }
        self.createBTN.isEnabled = true
        self.messageLBL.text = ""
    }
    
    @IBAction func createUser(_ sender: UIButton) {
        guard !(self.nameTF.text!).isEmpty,  !(self.countryTF.text!).isEmpty, !(self.birthdayTF.text!).isEmpty else{
            self.messageLBL.text = "Enter valid details"
            return
        }
        guard !(self.email.text!).isEmpty else{
            self.messageLBL.text = "Enter valid email"
            return
        }
        guard !(self.passwordTF.text!).isEmpty,  !(self.checkPasswordTF.text!).isEmpty else{
            self.messageLBL.text = "Enter valid password"
            return
        }
        Task {
            do{
                let authResult = try await AuthenticationManager.shared.createUser(email: self.email.text!, password: self.passwordTF.text!)
                let userData: [String: Any] = [
                    "name": self.nameTF.text ?? "",
                    "birthday": self.birthdayTF.text ?? "",
                    "country": self.countryTF.text ?? ""
                ]
                self.db.collection("users").document(authResult.uid).setData(userData) { error in
                    if let error = error {
                        print("Error writing user data to Firestore: \(error.localizedDescription)")
                        // Handle the error appropriately
                    } else {
                        print("User registered successfully with additional data!")
                        self.performSegue(withIdentifier: "registerToLogin", sender: self)
                    }
                }
                
            } catch {
                self.messageLBL.text = error.localizedDescription
            }
        }
    }
    
    
    @IBAction func cancelRegister(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "registerToLogin", sender: self)
    }
    
}
