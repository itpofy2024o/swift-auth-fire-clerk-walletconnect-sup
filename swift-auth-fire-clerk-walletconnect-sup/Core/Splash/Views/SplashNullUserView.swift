//
//  SplashNullUserView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            SplashBaseBackgroundView(image:"infographic")
            VStack {
                Spacer()
                SplashOverTextView(pageIndex: 0,
                    title:"This is Rudimentary!",
                    content:"It is a fabulous journey that we have been through, le's keep it up and start rolling!"
                ).background(.white)
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        ZStack {
            SplashBaseBackgroundView(image:"")
            VStack {
                Spacer()
                SplashOverTextView(pageIndex: 1,
                    title:"This is Fabulous!",
                    content:"It is an amazing journey that we have been through, le's keep it up and start rolling!"
                ).background(.white)
            }
        }
    }
}

struct AuthPromptView: View {
    var body: some View {
        ZStack {
            SplashBaseBackgroundView(image:"")
            VStack {
                Spacer()
                SplashOverTextView(pageIndex: 2,
                    title:"This isn't Amazing?",
                    content:""
                ).background(.white)
            }
        }
    }
}

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id:\.self) { index in
                Circle()
                    .fill(self.currentPage == index ? Color.orange : Color.purple)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, UIScreen.main.bounds.height*0.08)
    }
}

struct SplashNullUserView: View {
    @State private var currentPage: Int = 0
    @GestureState private var dragOffset = CGSize.zero

    let pages: [AnyView] = [
        AnyView(IntroView()),
        AnyView(AboutView()),
        AnyView(AuthPromptView())
    ]
    
    private let pageCount = 3
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(0..<pageCount, id: \.self) { index in
                            pages[index]
                        }
                    }
                    .offset(x: -CGFloat(self.currentPage) * geometry.size.width + self.dragOffset.width)
                    .animation(.easeInOut, value: self.currentPage)
                    
                    PageControl(numberOfPages: pageCount, currentPage: self.$currentPage)
                        .position(x: geometry.size.width / 2, y: geometry.size.height - 35)
                }
                .gesture(
                    DragGesture()
                        .updating(self.$dragOffset) { value, state, _ in
                            state = value.translation
                        }
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            if value.translation.width < -threshold {
                                self.currentPage = min(self.currentPage + 1, pageCount - 1)
                            } else if value.translation.width > threshold {
                                self.currentPage = max(self.currentPage - 1, 0)
                            }
                        }
                )
            }
        }
    }
}

#Preview {
    SplashNullUserView()
}
