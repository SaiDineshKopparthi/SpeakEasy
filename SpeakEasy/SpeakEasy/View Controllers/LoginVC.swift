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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoAnimation.animation = LottieAnimation.named("Animation_LoginScreen")
        self.logoAnimation.loopMode = .loop
        self.logoAnimation.play()
    }
    
    @IBAction func login(_ sender: UIButton) {
    }
    @IBAction func register(_ sender: UIButton) {
    }
    @IBAction func resetPassword(_ sender: UIButton) {
    }
    
}
