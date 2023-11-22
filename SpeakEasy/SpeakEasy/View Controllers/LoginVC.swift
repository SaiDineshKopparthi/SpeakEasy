//
//  LoginVC.swift
//  SpeakEasy
//
//  Created by Kopparthi,Sai Dinesh on 10/30/23.
//

import UIKit
import Lottie

class LoginVC: UIViewController {
    
    @IBOutlet weak var logoAnimation: LottieAnimationView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var messageLBL: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoAnimation.animation = LottieAnimation.named("Animation_LoginScreen")
        self.logoAnimation.loopMode = .loop
        self.logoAnimation.play()
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard !(self.userNameTF.text!).isEmpty else {
            self.messageLBL.text = "Please enter username!"
            return
        }
        guard !(self.passwordTF.text!).isEmpty else {
            self.messageLBL.text = "Please enter password!"
            return
        }
        Task{
            do{
                try await AuthenticationManager.shared.signIn(email: self.userNameTF.text!, password: self.passwordTF.text!)
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            catch {
                print(error)
                self.messageLBL.text = "Invalid Login Credentials"
                
            }
        }
    }
    
}
