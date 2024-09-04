//
//  ProfileView.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import SwiftUI
import ClerkSDK

struct ProfileView: View {
    @ObservedObject private var clerk = Clerk.shared
    @EnvironmentObject var viewModel: AuthFirebaseViewModel
    var body: some View {
//        if let currentUser = viewModel.currentUser {
//            List {
//                let firstWordSubSequence: String.SubSequence? = currentUser.email.split(separator: "@").first
//                let email = firstWordSubSequence.map(String.init) ?? ""
//
//                InfoCardView(username: currentUser.fullname, email: email)
//                    .listRowBackground(Color.clear)
//                
//                Section("FootPrint") {
//                    Text("")
//                }
//                
//                Section("Preferences") {
//                    PreferenceRowView(
//                        iconName: "gear", header: "settings", tint: Color(.systemGray)
//                    )
//                }
//                
//                Section("Account") {
//                    Button {
//                        Task {
//                            do {
//                                viewModel.authStatus == .googled
//                                ? try await viewModel.logoutgg() : viewModel.singOut()
//                            } catch {
//                                    print("")
//                                }
//                        }
//                    } label : {
//                        Text("Log Out").foregroundColor(.gray)
//                    }
//                    
//                    Button {
//                        Task {
//                            await viewModel.deleteYourAccount()
//                        }
//                    } label : {
//                        Text("Delete Account").foregroundColor(.red)
//                    }
//                }
//            }
//        } else {
//            CenteredTextWithIndicator()
//        }
        if clerk.user != nil {
            List {
                Section("FootPrint") {
                    Text("")
                }
                
                Section("Preferences") {
                    PreferenceRowView(
                        iconName: "gear", header: "settings", tint: Color(.systemGray)
                    )
                }
                
                Section("Account") {
                    Button {
                        Task { try? await clerk.signOut() }
                    } label : {
                        Text("Log Out").foregroundColor(.gray)
                    }
                }
            }
        } else {
            CenteredTextWithIndicator()
        }
    }
}

struct CenteredTextWithIndicator: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Text("Loading...").padding(.leading,10)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView().environmentObject(AuthFirebaseViewModel())
}
