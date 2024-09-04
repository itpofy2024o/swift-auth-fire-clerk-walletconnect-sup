//
//  ClockSignUporSignInView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI

struct ClockSignUpOrSignInView: View {
  @State private var isSignUp = true
  
  var body: some View {
    ScrollView {
      if isSignUp {
        ClockSignUpView()
      } else {
        ClockSignInView()
      }
      
      Button {
        isSignUp.toggle()
      } label: {
        if isSignUp {
          Text("Already have an account? Sign In")
        } else {
          Text("Don't have an account? Sign Up")
        }
      }
      .padding()
    }
  }
}

#Preview {
    ClockSignUpOrSignInView()
}
