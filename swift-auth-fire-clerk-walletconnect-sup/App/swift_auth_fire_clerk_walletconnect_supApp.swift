//
//  swift_auth_fire_clerk_walletconnect_supApp.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI
import FirebaseCore

@main
struct swift_auth_fire_clerk_walletconnect_supApp: App {
    @StateObject var viewModel = AuthFirebaseViewModel()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
