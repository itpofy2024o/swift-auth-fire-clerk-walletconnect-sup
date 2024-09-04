//
//  swift_auth_fire_clerk_walletconnect_supApp.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI
import GoogleSignIn
import FirebaseCore
import ClerkSDK

@main
struct swift_auth_fire_clerk_walletconnect_supApp: App {
    @ObservedObject private var clerk = Clerk.shared
    @StateObject var viewModel = AuthFirebaseViewModel()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if clerk.loadingState == .notLoaded {
                  ProgressView()
                } else {
//                    ContentView()
//                        .environmentObject(viewModel).onOpenURL { url in
//                            GIDSignIn.sharedInstance.handle(url)
//                        }
                    ClockContentView()
                }
           }.task {
                clerk.configure(publishableKey: "pk_test_cXVpY2stc2FsbW9uLTU3LmNsZXJrLmFjY291bnRzLmRldiQ")
                try? await clerk.load()
           }
        }
    }
}
