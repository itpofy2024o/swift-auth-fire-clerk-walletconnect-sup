//
//  FirebaseAuthViewModel.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import Foundation
import FirebaseAuth

class AuthFirebaseViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserFirebase?
    
    init () {
        
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        print("log in")
    }
    
    func createNewUser(
        withEmail email: String,
        password: String,
        username: String,
        firstname: String,
        lastname: String
    ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let fullname = "\(firstname) \(lastname)"
            let user = UserFirebase(id:result.user.uid,fullname:fullname,username:username,email:email)
        } catch {
            
        }
    }
    
    func singOut() {
        
    }
    
    func deleteYourAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
