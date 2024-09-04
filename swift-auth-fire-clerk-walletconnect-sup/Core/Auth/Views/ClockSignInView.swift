//
//  ClockSignInView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI
import ClerkSDK

struct ClockSignInView: View {
  @State private var email = ""
  @State private var password = ""
  
  var body: some View {
    VStack {
      Text("Sign In")
      TextField("Email", text: $email)
      SecureField("Password", text: $password)
      Button("Continue") {
        Task { await submit(email: email, password: password) }
      }
    }
    .padding()
  }
}

extension ClockSignInView {
    
  func submit(email: String, password: String) async {
    do {
      try await SignIn.create(
        strategy: .identifier(email, password: password)
      )
    } catch {
      dump(error)
    }
  }
    
}

#Preview {
    ClockSignInView()
}
