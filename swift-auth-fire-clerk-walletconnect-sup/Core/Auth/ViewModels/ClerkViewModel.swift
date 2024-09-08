//
//  ClerkViewModel.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 29/8/2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import ClerkSDK
import Combine

class ClerkViewModel: ObservableObject {
    @ObservedObject private var clerk = Clerk.shared
    @Published var currentUser: UserFirebase?
    @Published var authStatus: AuthStatus = .unknown
    @Published var email: String = ""
    @Published var otpCode: String = ""
    @Published var fullname: String = ""
    @Published var username: String = ""
    
    enum AuthStatus {
        case loggedIn
        case loggedOut
        case unknown
    }
    
    func authenticateUser() {
    }
}
