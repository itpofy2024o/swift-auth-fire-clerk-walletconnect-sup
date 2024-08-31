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
    @State private var shouldNavigate: Bool = false
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
                        withAnimation {
                            isResetLinkSent = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                shouldNavigate = true
                            }
                        }
                    }
                }
                .padding().disabled(!isValid)
                .opacity(isValid ? 1.0 : 0.42)
                
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
            .navigationDestination(isPresented: $shouldNavigate) {
                AuthView(method: "firebase")
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

extension ForgetPasswordView: FirebaseAuthenticanFormProtocol {
    var isValid: Bool {
        return !email.isEmpty && email.contains("@") && email.contains(".")
    }
}

#Preview {
    ForgetPasswordView().environmentObject(AuthFirebaseViewModel())
}
