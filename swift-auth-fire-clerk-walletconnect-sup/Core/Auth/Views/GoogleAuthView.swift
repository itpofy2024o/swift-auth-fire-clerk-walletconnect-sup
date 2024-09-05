//
//  GoogleAuthView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 4/9/2024.
//

import SwiftUI

struct GoogleAuthView: View {
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    @State private var err : String = ""
    var body: some View {
        Text("Google SSO Login")
        Button{
            Task {
            }
        }label: {
            HStack {
                Image(systemName: "person.badge.key.fill")
                Text("Sign in with Google")
            }.padding(8)
        }.buttonStyle(.borderedProminent)
        
        Text(err).foregroundColor(.red).font(.caption)
    }
}

#Preview {
    GoogleAuthView()
}
