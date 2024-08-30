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
        if (viewModel.currentUser != nil) {
            let firstWordSubSequence: String.SubSequence? = viewModel.currentUser!.email.split(separator: "@").first
            let email = firstWordSubSequence.map(String.init) ?? ""
            List {
                InfoCardView(username: viewModel.currentUser!.fullname, email:email).listRowBackground(Color.clear)
                
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
        } else {
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
            }
        }
    }
}

#Preview {
    ProfileView().environmentObject(AuthFirebaseViewModel())
}
