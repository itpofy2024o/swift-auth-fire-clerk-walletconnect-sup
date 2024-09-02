//
//  ContentView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    @State private var showSplash = true
    @Environment(\.scenePhase) private var scenePhase
    
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
                switch viewModel.authStatus {
                    case .loggedIn:
                        AppTabBarView()
                    case .loggedOut:
                        AuthView(method:"")
                            .environmentObject(viewModel)
                    case .unknown:
                        EmptyView()
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
        .onAppear() {
            Task {
                await viewModel.fetchUser()
                viewModel.updateAuthStatus()
            }
        }
    }
}


#Preview {
    ContentView().environmentObject(AuthFirebaseViewModel())
}
