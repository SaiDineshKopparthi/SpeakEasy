//
//  Model.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/21/23.
//

import Foundation
import Alamofire

//enum Languages: String, CaseIterable {
//    case English
//    case Spanish
//    case French
//    case German
//    case Italian
//    case Portuguese
//    case Russian
//    case Chinese
//    case Japanese
//    case Arabic
//
//
//    var code: String{
//        switch self{
//        case .English:
//            "en"
//        case .Spanish:
//            "es"
//        case .French:
//            "fr"
//        case .German:
//            "de"
//        case .Italian:
//            "it"
//        case .Portuguese:
//            "pt"
//        case .Russian:
//            "ru"
//        case .Chinese:
//            "zh"
//        case .Japanese:
//            "ja"
//        case .Arabic:
//            "ar"
//        }
//    }
//}

enum Languages: String, CaseIterable {
    case English
    case Spanish
    case French
    case German
    case Italian
    case Portuguese
    case Russian
    case Chinese
    case Japanese
    case Arabic


    var code: String{
        switch self{
        case .English:
            "en_GB"
        case .Spanish:
            "es_ES"
        case .French:
            "fr_Fr"
        case .German:
            "de_DE"
        case .Italian:
            "it_IT"
        case .Portuguese:
            "pt_PT"
        case .Russian:
            "ru_RU"
        case .Chinese:
            "zh_ZH"
        case .Japanese:
            "ja_JA"
        case .Arabic:
            "ar_AR"
        }
    }
}


struct Aloma{
    private static let apiKey = "Bearer a_AD2yk6BqfROJCq6TLfGRD7Srq6TENYQsZrU6okdzjokNKxLeMPxeaVygeAbmlqptEc0oA7zdf32sZ1HR"
    private static let url = "https://api-b2b.backenster.com/b1/api/v3/translate"
    private static let contentType = "application/json"
    private static let platform = "api"
    
    static func translateText(from: String, to: String, with: String) -> String{
        let headers: HTTPHeaders = [
            "Authorization": self.apiKey,
            "Accept": self.contentType,
            "Content-Type": self.contentType
        ]
        
        let parameters: [String: Any] = [
            "from": from,
            "to": to,
            "data": with,
            "platform": self.platform
        ]
//        
//        print(from)
//        print(to)
//        print(with)
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let valueDict = value as? [String: Any],
                   let resultValue = valueDict["result"] as? String {
                    print("Result: \(resultValue)")
                    return resultValue
                } else {
                    print("Failed to extract 'result' from the JSON-like structure.")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        return ""
    }
}
