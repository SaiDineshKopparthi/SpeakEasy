//
//  SplashScreenVC.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 10/29/23.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {

    @IBOutlet weak var logoAnimationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoAnimationView.animation = LottieAnimation.named("Animation_LaunchScreen")
        self.logoAnimationView.loopMode = .loop
        self.logoAnimationView.play()
        
        //Navigates to Login Screen after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            self.performSegue(withIdentifier: "splashToLogin", sender: nil)
        }
        
    }

}
