//
//  FirebaseAuthViewModel.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseAuthenticanFormProtocol {
    var isValid: Bool { get }
}

@MainActor
class AuthFirebaseViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserFirebase?
    
    init () {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        do {
            let res = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = res.user
            await fetchUser()
        } catch {
            print("debug sign in: \(error.localizedDescription)")
        }
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
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("firebase create new user: \(error.localizedDescription)")
        }
    }
    
    func singOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG sign out: \(error.localizedDescription)")
        }
    }
    
    func deleteYourAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: UserFirebase.self)
        print("debug currentUser: \(self.currentUser as Any)")
    }
}
