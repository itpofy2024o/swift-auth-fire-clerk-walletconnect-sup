//
//  ContentView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    @Binding var isActive: Bool
    @State private var isSplashShown: Bool = UserDefaults.standard.bool(forKey: "hasShownSplash")
    @State private var showSplash: Bool = true
    var body: some View {
        Group {
            if showSplash {
                if viewModel.userSession != nil {
                    SplashAuthedView(isSplashShown: $isSplashShown)
                } else {
                    SplashUnitedView(isSplashShown: $isSplashShown)
                }
            } else {
                if viewModel.userSession != nil {
                    AppTabBarView()
                } else {
                    AuthView(method: "firebase")
                }
            }
        }
        .onChange(of: viewModel.userSession) {
            if viewModel.userSession != nil && isActive {
                UserDefaults.standard.set(true, forKey: "hasShownSplash")
                isSplashShown = true
            }
        }
        .onChange(of: isActive) {
            if !isActive { // App went to background
                showSplash = true
            } else { // App became active
                if isSplashShown {
                    showSplash = false
                }
            }
        }
        .onAppear {
            if !isSplashShown {
                showSplash = true
            }
        }
    }
}

#Preview {
    ContentView(isActive: Binding.constant(true)).environmentObject(AuthFirebaseViewModel())
}
