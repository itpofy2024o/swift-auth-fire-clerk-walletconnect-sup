//
//  FirebaseAuthViewModel.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

protocol FirebaseAuthenticanFormProtocol {
    var isValid: Bool { get }
}

@MainActor
class AuthFirebaseViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserFirebase?
    @Published var authStatus: AuthStatus = .unknown
    
    enum AuthStatus {
        case loggedIn
        case loggedOut
        case unknown
    }
    
    init () {
        self.userSession = Auth.auth().currentUser
        updateAuthStatus()
        Task {
            await fetchUser()
        }
    }
    
    func updateAuthStatus() {
        if userSession != nil {
            authStatus = .loggedIn
        } else {
            authStatus = .loggedOut
        }
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        do {
            let res = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = res.user
            updateAuthStatus()
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
            let newUser = UserFirebase(id:result.user.uid,fullname:fullname,username:username,email:email)
            let encodedUser = try Firestore.Encoder().encode(newUser)
            try await Firestore.firestore().collection("users").document(newUser.id).setData(encodedUser)
            
            if let user = Auth.auth().currentUser {
                try await user.sendEmailVerification()
                print("Verification email sent to \(email)")
                var isVerified = false
                while !isVerified {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    try await user.reload() // Reload the user's data
                    isVerified = user.isEmailVerified
                }
                if user.isEmailVerified {
                    print("Email \(email) and \(fullname) are verified.")
                    updateAuthStatus()
                    await fetchUser()
                } else {
                    print("Email is not verified. Prompt user to verify.")
                }
            }
        } catch {
            print("firebase create new user: \(error.localizedDescription)")
        }
    }
    
    func resendEmailVerification() async throws {
        guard let currentUser = Auth.auth().currentUser else {
            print("No user is currently signed in.")
            return
        }
        
        do {
            try await currentUser.sendEmailVerification()
            print("Verification email resent to \(currentUser.email ?? "unknown email").")
        } catch {
            print("Failed to resend verification email: \(error.localizedDescription)")
        }
    }
    
    func singOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            updateAuthStatus()
        } catch {
            print("DEBUG sign out: \(error.localizedDescription)")
        }
    }
    
    func deleteYourAccount() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: No user is currently signed in.")
            return
        }
        
        do {
            let firestore = Firestore.firestore()
            try await firestore.collection("users").document(uid).delete()
            
            try await Auth.auth().currentUser?.delete()
            
            self.userSession = nil
            self.currentUser = nil
            
            updateAuthStatus()
        } catch {
            print("DEBUG delete user: \(error.localizedDescription)")
        }
    }
    
    func resetPassword(forEmail email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            print("Password reset email sent.")
        } catch {
            print("DEBUG reset password: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: UserFirebase.self)
    }
}
