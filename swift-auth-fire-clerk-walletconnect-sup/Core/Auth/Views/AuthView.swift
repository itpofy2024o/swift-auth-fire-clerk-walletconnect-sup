//
//  AuthView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI
import Kingfisher

struct AuthView: View {
    @State private var email = ""
    @State private var passwd = ""
    let method: String
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                KFImage(URL(string:"https://moralis.io/wp-content/uploads/2023/11/Phantom-Wallet.png"))
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width*0.4)
                    .cornerRadius(25)
                    .padding(.vertical,26)
                
                VStack(spacing: 26) {
                    AuthenticationInputView(text:$email,label: "Email Address",placeholder: "example@gmail.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    AuthenticationInputView(text:$passwd,label: "Password",placeholder: "thisispassword_youknowit",isSecureInfo: true)
                }
                .padding(.horizontal,28)
                .padding(.top,UIScreen.main.bounds.width*0.05)
                
                Button {
                    Task {
                        try await viewModel.signIn(
                            withEmail:email, password:passwd)
                    }
                    print("signing in")
                } label: {
                    HStack {
                        Text("SIGN IN").fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-85,height: 44)
                        .padding(5)
                }
                .disabled(!isValid)
                .opacity(isValid ? 1.0 : 0.42)
                .background(.green)
                .cornerRadius(17)
                .padding(.top,12)
                .padding(.bottom,12)
                
                NavigationLink {
                    ForgetPasswordView()
                } label : {
                    Text("Forgot Password?")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(colorScheme == .dark ? Color(.green):Color(.orange))
                }.padding(.top,12)
                    .padding(.bottom,12)
                
                NavigationLink {
                    GoogleAuthView()
                } label : {
                    Text("Use Google to Log In")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(colorScheme == .dark ? Color(.blue):Color(.blue))
                }
                
                Spacer()
                
                NavigationLink {
                    RegisterView().navigationBarBackButtonHidden(true)
                } label : {
                    HStack {
                        Text("haven't join us yet?").font(.system(size: 15)).fontWeight(.light)
                        Text("Well come right in!").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 17))
                    }
                }
            }
        }
    }
}

extension AuthView: FirebaseAuthenticanFormProtocol {
    var isValid: Bool {
        return !email.isEmpty && email.contains("@") &&
        !passwd.isEmpty && passwd.count > 7
    }
}

#Preview {
    AuthView(method:"firebase")
}
