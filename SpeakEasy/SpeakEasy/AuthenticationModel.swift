//
//  AuthenticationModel.swift
//  SpeakEasy
//
//  Created by Kopparthi Sai Dinesh on 11/19/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func getCurrentUser() -> AuthDataResultModel{
        let authDataResult = Auth.auth().currentUser
        return AuthDataResultModel(user: authDataResult!)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    func resetPassword(email :String) async throws{
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Password reset email sent successfully.")
        } catch {
            print("Error sending password reset email: \(error.localizedDescription)")
            throw error
        }
    }
}
