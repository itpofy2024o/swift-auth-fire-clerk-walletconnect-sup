//
//  SplashBaseBackgroundView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

func doesImageExist(named imageName: String) -> Bool {
    return UIImage(named: imageName) != nil // useful util
}

struct SplashBaseBackgroundView: View {
    let image: String
        var body: some View {
            if image.count > 0 && doesImageExist(named: image) == true {
                Image(image).resizable().scaledToFit()
            } else {
                Color(
                    red:150.0/255.0,
                    green:252.0/255.0,
                    blue:204.0/255.0
                ).opacity(0.8).ignoresSafeArea()
            }
        }
}

#Preview {
    SplashBaseBackgroundView(image: "insdfo")
}
