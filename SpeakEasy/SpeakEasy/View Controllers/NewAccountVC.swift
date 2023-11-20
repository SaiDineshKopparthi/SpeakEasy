//
//  NewAccountVC.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/19/23.
//

import UIKit

class NewAccountVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createUser(_ sender: UIButton) {
        Task {
            do{
                try await AuthenticationManager.shared.createUser(email: self.email.text!, password: self.passwordTF.text!)
            }
        }
        
    }
    
    
}
