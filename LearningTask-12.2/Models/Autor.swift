//
//  Autor.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

struct Autor: Codable {
    let id: Int?
    let fotoURI: URL
    let nome: String
    let sobrenome: String
    let bio: String
    let tecnologias: [String]
    
    var nomeCompleto: String {
        return "\(nome) \(sobrenome)"
    }
    
    init(id: Int? = nil, foto: URL, nome: String, sobrenome: String, bio: String, tecnologias: [String]) {
        self.id = id
        self.fotoURI = foto
        self.nome = nome
        self.sobrenome = sobrenome
        self.bio = bio
        self.tecnologias = tecnologias
    }
    
    enum CodingKeys: String, CodingKey {
        case id, bio
        case fotoURI = "profilePicturePath"
        case nome = "firstName"
        case sobrenome = "lastName"
        case tecnologias = "technologies"
    }
}

