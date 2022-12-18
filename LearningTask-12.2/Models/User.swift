//
//  User.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import Foundation

struct User: Codable {
    let id: Int?
    let email: String
    let fullName: String
    
    init(id: Int? = nil, email: String, fullName: String) {
        self.id = id
        self.email = email
        self.fullName = fullName
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case fullName = "name"
    }
}
