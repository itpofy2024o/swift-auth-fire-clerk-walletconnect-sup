//
//  AppTabBarView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct AppTabBarView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    @State private var selectedTab: Int = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("A")
                .tabItem{Image(systemName: "magnifyingglass")}
                .tag(0)
            MainView()
                .tabItem{Image(systemName: "water.waves")}
                .tag(1)
            if viewModel.currentUser != nil {
                ProfileView()
                    .tabItem { Image(systemName: "person") }
                    .tag(2)
            }
        }
        .tint(.primary)
    }
}

#Preview {
    AppTabBarView().environmentObject(AuthFirebaseViewModel())
}
