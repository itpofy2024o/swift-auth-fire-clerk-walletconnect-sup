//
//  ClockSignUpView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI
import ClerkSDK

struct ClockSignUpView: View {
  @State private var email = ""
  @State private var password = ""
  @State private var code = ""
  @State private var isVerifying = false
  
  var body: some View {
    VStack {
      Text("Sign Up")
      if isVerifying {
        TextField("Code", text: $code)
        Button("Verify") {
          Task { await verify(code: code) }
        }
      } else {
        TextField("Email", text: $email)
        SecureField("Password", text: $password)
        Button("Continue") {
          Task { await signUp(email: email, password: password) }
        }
      }
    }
    .padding()
  }
}

extension ClockSignUpView {
  
  func signUp(email: String, password: String) async {
    do {
      let signUp = try await SignUp.create(
        strategy: .standard(emailAddress: email, password: password)
      )
      
        try await signUp.prepareVerification(strategy: .emailCode)

      isVerifying = true
    } catch {
      dump(error)
    }
  }
  
  func verify(code: String) async {
    do {
        guard let signUp = await Clerk.shared.client?.signUp else {
        isVerifying = false
        return
      }
      
      try await signUp.attemptVerification(.emailCode(code: code))
    } catch {
      dump(error)
    }
  }
  
}

#Preview {
    ClockSignUpView()
}
