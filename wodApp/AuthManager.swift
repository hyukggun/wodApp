//
//  AuthManager.swift
//  wodApp
//
//  Created by 최최광현 on 2023/08/23.
//

import Foundation
import Supabase

protocol AuthManager {
    func signIn(email: String,
                password: String) async -> Bool
}

struct AuthManagerImpl: AuthManager {
    
    private let _client = SupabaseClient(supabaseURL: URL(string: Configuration.ProjectURL)!,
                                         supabaseKey: Configuration.PublicKey)
    
    func signIn(email: String,
                password: String) async -> Bool {
        do {
            _ = try await _client.auth.signIn(email: email, password: password)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
