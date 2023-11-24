//
//  TranslationVC.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/21/23.
//

import UIKit

class TranslationVC: UIViewController {

    @IBOutlet weak var inputLangBTN: UIButton!
    @IBOutlet weak var targetLangBTN: UIButton!
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var translatedTV: UITextView!
    
    private var inputLangCode = String()
    private var targetLangCode = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.languageButtonSetUp()
    }
    
    private func languageButtonSetUp(){
            let options = {(action: UIAction) in print(action.title)}
            
            self.inputLangBTN.menu = UIMenu(title: "Language", children: [UIAction(title: "Italian", handler: options),
                                                                          UIAction(title: "German", handler: options),
                                                                          UIAction(title: "French", handler: options),
                                                                          UIAction(title: "Spanish", handler: options),
                                                                          UIAction(title: "Portuguese", handler: options),
                                                                          UIAction(title: "Russian", handler: options),
                                                                          UIAction(title: "Chinese", handler: options),
                                                                          UIAction(title: "Japanese", handler: options),
                                                                          UIAction(title: "Arabic", handler: options),
                                                                          UIAction(title: "English", state: .on, handler: options),
                                                                          UIAction(title: "Hindi", handler: options),
                                                                          UIAction(title: "Korean", handler: options)])
        self.targetLangBTN.menu = UIMenu(title: "Language", children: [UIAction(title: "Italian", handler: options),
                                                                       UIAction(title: "German", handler: options),
                                                                       UIAction(title: "French", handler: options),
                                                                       UIAction(title: "Spanish", state: .on, handler: options),
                                                                       UIAction(title: "Portuguese", handler: options),
                                                                       UIAction(title: "Russian", handler: options),
                                                                       UIAction(title: "Chinese", handler: options),
                                                                       UIAction(title: "Japanese", handler: options),
                                                                       UIAction(title: "Arabic", handler: options),
                                                                       UIAction(title: "English", handler: options),
                                                                       UIAction(title: "Hindi", handler: options),
                                                                       UIAction(title: "Korean", handler: options),])
        self.targetLangBTN.showsMenuAsPrimaryAction = true
        self.targetLangBTN.changesSelectionAsPrimaryAction = true
        self.inputLangBTN.showsMenuAsPrimaryAction = true
        self.inputLangBTN.changesSelectionAsPrimaryAction = true
    }
    
    
    @IBAction func translateText(_ sender: UIButton) {
        guard let inputText = self.inputTF.text, !inputText.isEmpty else{
            self.translatedTV.text = "Please enter valid text to translate!"
            self.translatedTV.textColor = .red
            return
        }
        self.translatedTV.text = ""
        self.translatedTV.textColor = .black
        let inputLanguage = self.inputLangBTN.titleLabel?.text
        let targetLanguage = self.targetLangBTN.titleLabel?.text
        
        for lang in Languages.allCases {
            if(inputLanguage == lang.rawValue){
                self.inputLangCode = lang.code
            }
            if(targetLanguage == lang.rawValue){
                self.targetLangCode = lang.code
            }
        }
        
        Aloma.translateText(from: self.inputLangCode, to: self.targetLangCode, with: inputText){ result in
            self.translatedTV.text = result
        }
        
    }
    
//    @IBAction func translateText(_ sender: UIButton) {
//        guard let inputText = self.inputTF.text, !inputText.isEmpty else{
//            self.translatedTV.text = "Please enter valid text to translate!"
//            self.translatedTV.textColor = .red
//            return
//        }
//        self.translatedTV.text = ""
//        self.translatedTV.textColor = .black
//        let inputLanguage = self.inputLangBTN.titleLabel?.text
//        let targetLanguage = self.targetLangBTN.titleLabel?.text
//
//        for lang in Languages.allCases {
//            if(inputLanguage == lang.rawValue){
//                self.inputLangCode = lang.code
//            }
//            if(targetLanguage == lang.rawValue){
//                self.targetLangCode = lang.code
//            }
//        }
//
//        if let encodedText = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: "https://api.mymemory.translated.net/get?q=\(encodedText)&langpair=\(self.inputLangCode)|\(self.targetLangCode)") {
//
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                        if let responseData = json?["responseData"] as? [String: Any],
//                            let translatedText = responseData["translatedText"] as? String {
//                            DispatchQueue.main.async {
//                                self.translatedTV.text = translatedText
//                            }
//                        }
//                    } catch {
//                        print("Error decoding JSON: \(error.localizedDescription)")
//                    }
//                } else if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                }
//            }.resume()
//
//        }
//
//    }
    
}
