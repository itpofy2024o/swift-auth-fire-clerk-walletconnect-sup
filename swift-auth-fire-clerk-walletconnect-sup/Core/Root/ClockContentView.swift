//
//  ClockContentView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI
import ClerkSDK

struct ClockContentView: View {
    @State private var showSplash = true
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var clerk = Clerk.shared
    var body: some View {
        ZStack {
            if showSplash {
                SplashOnlyView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false
                        }
                    }
            } else {
                if clerk.user != nil {
                    AppTabBarView()
                } else {
                    ClockSignUpOrSignInView()
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                showSplash = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ClockContentView()
}
