//
//  ClockSignUpView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI
import ClerkSDK

struct ClockSignUpView: View {
  var body: some View {
    VStack {
      Text("Sign In with Spotify")
        .font(.title)
        .padding(.bottom, 20)
      
      Button(action: {
        Task {
          await signInWithSpotify()
        }
      }) {
        HStack {
          Image(systemName: "music.note")
          Text("Continue with Spotify")
        }
        .font(.headline)
        .padding()
        .background(Color.green)
        .foregroundColor(.white)
        .cornerRadius(10)
      }
    }
    .padding()
  }
}

extension ClockSignUpView {
  
  func signInWithSpotify() async {
    do {
      try await SignIn.create(strategy: .oauth(.spotify))
    } catch {
        print("err \(error.localizedDescription)")
    }
  }
}


#Preview {
    ClockSignUpView()
}
