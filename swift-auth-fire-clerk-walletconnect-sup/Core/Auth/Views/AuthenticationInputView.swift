//
//  AuthenticationInputView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct AuthenticationInputView: View {
    @Binding var text: String
    let label: String
    let placeholder: String
    var isSecureInfo = false
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
            Text(label)
                .fontWeight(.heavy)
                .font(.title3)
            if isSecureInfo {
                SecureField(placeholder,text:$text)
                    .font(.system(size:17))
                    .textContentType(.none)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder,text:$text)
                    .font(.system(size: 17))
            }
            Divider()
        }
    }
}

#Preview {
    AuthenticationInputView(text: .constant(""), label: "Gentle", placeholder: "Mov")
}
