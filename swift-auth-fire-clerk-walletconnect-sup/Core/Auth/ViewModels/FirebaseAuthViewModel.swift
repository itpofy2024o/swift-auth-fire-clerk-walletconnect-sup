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
    @Published var generatedOTP: String?
    
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
            let user = UserFirebase(id:result.user.uid,fullname:fullname,username:username,email:email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            updateAuthStatus()
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
    
    private func generateOTP() -> String {
        return String(Int.random(in: 100000..<999999))
    }
    
    private func sendOTPEmail(to email: String, otp: String) {
        print("Sending OTP \(otp) to email \(email)")
        // Integration with an external email API like SendGrid or SMTP server should be here
    }
    
    private func checkUserExistsInFirestore(email: String) async throws -> Bool {
        let db = Firestore.firestore()
        let userQuery = db.collection("users").whereField("email", isEqualTo: email)
        
        let snapshot = try await userQuery.getDocuments()
        return !snapshot.documents.isEmpty
    }
    
    func sendSignUpOTP(toEmail email: String) async {
        let otp = generateOTP()
        self.generatedOTP = otp
        sendOTPEmail(to: email, otp: otp)
        print("Sign-Up OTP sent to email.")
    }
    
    // Step 2: Verify OTP and complete Sign-Up
    func verifySignUpOTP(enteredOTP: String, email: String, password: String, username: String, firstname: String, lastname: String) async throws {
        if let otp = generatedOTP, otp == enteredOTP {
            try await createNewUser(withEmail: email, password: password, username: username, firstname: firstname, lastname: lastname)
            self.generatedOTP = nil
        } else {
            print("DEBUG: OTP verification failed.")
            throw NSError(domain: "OTPVerification", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"])
        }
    }
    
    // Step 1: Send OTP during Sign-In
    func sendSignInOTP(toEmail email: String) async throws {
        let t = try await checkUserExistsInFirestore(email: email)
        if t == true {
            let otp = generateOTP()
            self.generatedOTP = otp
            sendOTPEmail(to: email, otp: otp)
            print("Sign-In OTP sent to email.")
        }
    }
        
    // Step 2: Verify OTP and complete Sign-In
    func verifySignInOTP(enteredOTP: String, email: String, password: String) async throws {
        if let otp = generatedOTP, otp == enteredOTP {
            try await signIn(withEmail: email, password: password)
            self.generatedOTP = nil
        } else {
            print("DEBUG: OTP verification failed.")
            throw NSError(domain: "OTPVerification", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"])
        }
    }
}
