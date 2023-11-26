//
//  LoginVC.swift
//  SpeakEasy
//
//  Created by Kopparthi,Sai Dinesh on 10/30/23.
//

import UIKit
import Lottie
import CometChatUIKitSwift

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
        
        self.userNameTF.text = "alex@mail.com"
        self.passwordTF.text = "WEDsan121001@#"
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
                let user = try await AuthenticationManager.shared.signIn(email: self.userNameTF.text!, password: self.passwordTF.text!)
                let uid = user.uid
                CometChatUIKit.login(uid: uid) { result in
                    switch result {
                    case .success(let user):
                        debugPrint("User logged in successfully  \(String(describing: user.name))")
                        break
                    case .onError(let error):
                        debugPrint("Login failed with exception: \(error.errorDescription)")
                        break
                    @unknown default:
                        break
                    }
                }
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            catch {
                print(error)
                self.messageLBL.text = "Invalid Login Credentials"
                
            }
        }
    }
    
}
