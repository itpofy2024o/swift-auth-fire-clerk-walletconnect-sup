//
//  UserFirebase.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 28/8/2024.
//

import Foundation

struct UserFirebase: Identifiable, Codable {
    let id: String
    let fullname: String
    let username: String
    let email: String
}

extension UserFirebase {
    static var Mock_User_Firebase = UserFirebase(id:NSUUID().uuidString,fullname: "Shamnan Oana", username: "jason12",email: "test1828699@gmail.com")
}
