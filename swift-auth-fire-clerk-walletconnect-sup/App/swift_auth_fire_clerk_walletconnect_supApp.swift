//
//  swift_auth_fire_clerk_walletconnect_supApp.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI
import Firebase

@main
struct swift_auth_fire_clerk_walletconnect_supApp: App {
    @StateObject var viewModel = AuthFirebaseViewModel()
    @AppStorage("isActive") private var isActive: Bool = true
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(isActive: $isActive)
                .environmentObject(viewModel)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    isActive = true
                    print("UIApplication Status: \(isActive)")
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    isActive = false
                    print("UIApplication Status: \(isActive)")
                }
        }
    }
}
