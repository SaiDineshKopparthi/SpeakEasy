//
//  AuthenticationModel.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/19/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func createUser(email: String, password: String) async throws{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
}
