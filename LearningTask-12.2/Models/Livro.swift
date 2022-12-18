//
//  Livro.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

enum TipoDeLivro: String, CaseIterable, Decodable {
    case ebook = "EBOOK"
    case impresso = "HARDCOVER"
    case combo = "COMBO"
    
    var index: Int {
        switch self {
        case .ebook:
            return 0
        case .impresso:
            return 1
        case .combo:
            return 2
        }
    }
    
    var titulo: String {
        switch self {
        case .ebook:
            return "E-book"
        case .impresso:
            return "Impresso"
        case .combo:
            return "E-book + impresso"
        }
    }
}

struct Preco: Decodable {
    let valor: Decimal
    let tipoDeLivro: TipoDeLivro
    
    enum CodingKeys: String, CodingKey {
        case valor = "value"
        case tipoDeLivro = "bookType"
    }
}

struct Livro: Decodable {
    let id: Int?
    let titulo: String
    let subtitulo: String
    let imagemDeCapaURI: URL
    let autor: Autor
    let precos: [Preco]
    
    init(id: Int? = nil, titulo: String, subtitulo: String, imagemDeCapaURI: URL, autor: Autor, precos: [Preco]) {
        self.id = id
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.imagemDeCapaURI = imagemDeCapaURI
        self.autor = autor
        self.precos = precos
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case titulo = "title"
        case subtitulo = "subtitle"
        case imagemDeCapaURI = "coverImagePath"
        case autor = "author"
        case precos = "prices"
    }
}
