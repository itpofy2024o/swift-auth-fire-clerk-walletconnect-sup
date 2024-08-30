//
//  RegisterView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI
import Kingfisher

struct RegisterView: View {
    @State private var newEmail = ""
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var confirmation = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    
    var body: some View {
        VStack {
            KFImage(URL(string:"https://moralis.io/wp-content/uploads/2023/11/Phantom-Wallet.png"))
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.vertical,26)
            
            VStack(spacing: 15) {
                AuthenticationInputView(text:$username,label: "Username",placeholder: "elonthemuskpredicted")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                AuthenticationInputView(text:$newEmail,label: "Email Address",placeholder: "example@gmail.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                AuthenticationInputView(text:$firstName,label: "First Name",placeholder: "Alexander")
                AuthenticationInputView(text:$lastName,label: "Last Name",placeholder: "Bularia")
                AuthenticationInputView(text:$password,label: "Password",placeholder: "thisispassword_youknowit",isSecureInfo: true)
                ZStack(alignment:.trailing) {
                    AuthenticationInputView(text:$confirmation,label: "Confirm Password",placeholder: "xxxxxxxxxxxxxxxxxxxxxxxx",isSecureInfo: true)
                    if !password.isEmpty && !confirmation.isEmpty {
                        if password == confirmation {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal,28)
            .padding(.top,UIScreen.main.bounds.width*0.05)
            
            Button {
                Task {
                    try await viewModel.createNewUser(
                        withEmail:newEmail,password:password,
                        username:username,firstname:firstName,lastname:lastName)
                }
                print("Registration ing")
            } label: {
                HStack {
                    Text("SIGN UP").fontWeight(.semibold)
                    Image(systemName: "arrow.up")
                }.foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-85,height: 44)
                    .padding(5)
            }
            .background(.brown)
            .disabled(!isValid)
            .opacity(isValid ? 1.0 : 0.42)
            .cornerRadius(17)
            .padding(.top,20)
            
            Spacer()
            
            Button {
                dismiss()
            } label : {
                HStack(spacing: 3) {
                    Text("Already in the game!").font(.system(size: 15)).fontWeight(.light)
                    Text("Sign In").font(.system(size: 17)).fontWeight(.bold)
                }
            }
        }
    }
}

extension RegisterView: FirebaseAuthenticanFormProtocol {
    var isValid: Bool {
        return !newEmail.isEmpty && newEmail.contains("@") &&
        !password.isEmpty && password.count > 7
        && password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil
        && password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil
        && password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        && !firstName.isEmpty && !lastName.isEmpty &&
        firstName.count > 2 && lastName.count > 2 && confirmation == password && !username.isEmpty && username.count > 4 && username.count < 14
    }
}

#Preview {
    RegisterView()
}
