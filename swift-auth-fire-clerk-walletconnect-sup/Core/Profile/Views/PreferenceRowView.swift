//
//  PreferenceRowView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct PreferenceRowView: View {
    let iconName: String
        let header: String
        let tint: Color
        var body: some View {
            HStack(spacing:9) {
                HStack {
                    Image(systemName: iconName)
                        .imageScale(.small)
                        .font(.title)
                        .foregroundColor(tint)
                    
                    Text(header)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text("version 1.0")
            }
        }
}

#Preview {
    PreferenceRowView(
        iconName: "gear", header: "Setting", tint: Color(.systemGray))
}
