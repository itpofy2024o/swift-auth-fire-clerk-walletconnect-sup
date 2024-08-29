//
//  SupbaseViewModel.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 29/8/2024.
//

import Foundation

class SupabaseViewModel: ObservableObject {
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
        print("create new")
    }
    
    func singOut() {
        
    }
    
    func deleteYourAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
