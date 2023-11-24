//
//  resetPasswordVC.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/23/23.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var resetBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetBTN.isEnabled = false
    }
    
    @IBAction func emailAction(_ sender: UITextField) {
        self.resetBTN.isEnabled = true
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        guard let email = self.emailTF.text, !email.isEmpty else{
            self.messageLBL.text = "Please enter the email"
            return
        }
        Task{
            do{
                try await AuthenticationManager.shared.resetPassword(email: email)
                self.performSegue(withIdentifier: "resetToLogin", sender: self)
                self.resetBTN.isEnabled = false
            }catch {
                print("Error at Resetting password: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func cancelReset(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "resetToLogin", sender: self)
    }
    
    
}
