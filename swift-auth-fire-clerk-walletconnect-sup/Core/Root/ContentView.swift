//
//  ContentView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                SplashAuthedView()
            } else {
                SplashNullUserView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthFirebaseViewModel())
}
