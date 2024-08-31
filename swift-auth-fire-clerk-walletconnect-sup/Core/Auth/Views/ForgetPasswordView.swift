//
//  ForgetPasswordView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 31/8/2024.
//

import SwiftUI
import Kingfisher

struct ForgetPasswordView: View {
    @State private var email: String = ""
    @State private var isResetLinkSent: Bool = false
    @EnvironmentObject var authViewModel: AuthFirebaseViewModel

    var body: some View {
        NavigationStack {
            VStack {KFImage(URL(string:"https://moralis.io/wp-content/uploads/2023/11/Phantom-Wallet.png"))
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width*0.4)
                    .cornerRadius(25)
                    .padding(.vertical,26)
                
                AuthenticationInputView(text:$email,label: "Email Address",placeholder: "youremailaddress@smtp.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal,28)
                    .padding(.top,UIScreen.main.bounds.width*0.05)
                
                Button("Send Password Reset Link") {
                    Task {
                        await authViewModel.resetPassword(forEmail: email)
                        isResetLinkSent = true
                    }
                }
                .padding()
                
                if isResetLinkSent {
                    Text("Succeeded!!")
                        .font(.subheadline)
                        .foregroundColor(.green)
                    Text("Should the provided email was registed, a reset link is await in your email.")
                        .foregroundColor(.orange)
                        .font(.caption)
                }
            }
            .padding()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    return
                }
            }.navigationDestination(isPresented: $isResetLinkSent) {
                AuthView(method: "firebase")
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    ForgetPasswordView().environmentObject(AuthFirebaseViewModel())
}
