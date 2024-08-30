//
//  ProfileView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    let userName: String
        var body: some View {
            let firstWordSubSequence: String.SubSequence? = UserFirebase.Mock_User_Firebase.email.split(separator: "@").first
            let email = firstWordSubSequence.map(String.init) ?? ""
            List {
                InfoCardView(username: UserFirebase.Mock_User_Firebase.fullname, email:email).listRowBackground(Color.clear)
                
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
                            print("user - \(userName) logged out")
                        }
                    } label : {
                        Text("Log Out").foregroundColor(.gray)
                    }
                    
                    Button {
                        print("user - \(userName) deleted account")
                    } label : {
                        Text("Delete Account").foregroundColor(.red)
                    }
                }
            }
        }
}

#Preview {
    ProfileView(userName: "WonderWonn")
}
