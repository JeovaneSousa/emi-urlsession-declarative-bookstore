//
//  UserAuthentication.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import Foundation

struct Authentication: Codable {
    private var tokenType: String
    private var token: String
    
    let user: User
    
    var value: String {
        return "\(tokenType) \(token)"
    }
    
    init(tokenType: String = "Bearer", token: String, user: User) {
        self.tokenType = tokenType
        self.token = token
        self.user = user
    }
}

class UserAuthentication {
    private static let authenticationKey = "UserAuthentication"
    
    var userDefaults: UserDefaults
    var decoder: PropertyListDecoder
    var encoder: PropertyListEncoder
    
    init(userDefaults: UserDefaults = .standard,
         decoder :PropertyListDecoder = .init(),
         encoder: PropertyListEncoder = .init()) {
        self.userDefaults = userDefaults
        self.decoder = decoder
        self.encoder = encoder
    }
    
    var isAuthenticated: Bool {
        return get() != nil
    }
    
    func get() -> Authentication? {
        guard let authenticationData = userDefaults
            .object(forKey: Self.authenticationKey) as? Data else { return nil }
        
        guard let authentication = try? decoder.decode(Authentication.self, from: authenticationData) else { return nil }
        
        return authentication
    }
    
    func set(_ authentication: Authentication) {
        if let encoded = try? encoder.encode(authentication) {
            userDefaults.set(encoded, forKey: Self.authenticationKey)
            print("Usuário \(authentication.user.fullName) logado")
        }
    }

}
