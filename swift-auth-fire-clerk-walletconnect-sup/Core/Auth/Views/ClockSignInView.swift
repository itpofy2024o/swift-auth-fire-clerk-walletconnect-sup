//
//  ClockSignInView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI
import ClerkSDK

struct ClockSignInView: View {
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

extension ClockSignInView {
    
    func signInWithSpotify() async {
        do {
          // Trigger the OAuth flow for Spotify
          try await SignIn.create(strategy: .oauth(.spotify))
        } catch {
          dump(error)
        }
      }
    
}

#Preview {
    ClockSignInView()
}
