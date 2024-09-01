//
//  ProfileView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    var body: some View {
        List {
            if let currentUser = viewModel.currentUser {
                let firstWordSubSequence: String.SubSequence? = currentUser.email.split(separator: "@").first
                let email = firstWordSubSequence.map(String.init) ?? ""

                InfoCardView(username: currentUser.fullname, email: email)
                    .listRowBackground(Color.clear)
            } else {
                InfoCardView(username: "Unknown", email: "No Email")
                    .listRowBackground(Color.clear)
            }
            
            Section("FootPrint") {
                Text("")
            }
            
            Section("Preferences") {
                PreferenceRowView(
                    iconName: "gear", header: "settings", tint: Color(.systemGray)
                )
            }
            
            Section("Account") {
                Button {
                    Task {
                        viewModel.singOut()
                    }
                } label : {
                    Text("Log Out").foregroundColor(.gray)
                }
                
                Button {
                    Task {
                        await viewModel.deleteYourAccount()
                    }
                } label : {
                    Text("Delete Account").foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthFirebaseViewModel())
}
