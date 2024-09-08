//
//  SupbaseViewModel.swift
//  swift-auth-fire-clerk-walletconnect-sup
//
//  Created by Devor Vlad on 29/8/2024.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://vfxesnyaimaclafmhtvq.supabase.co")!,
  supabaseKey: ""
)

struct SupaUser: Decodable, Identifiable {
    let id: Int
    let name: String
    let email: String
}

class SupabaseViewModel {
    
}
