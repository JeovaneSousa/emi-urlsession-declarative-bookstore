//
//  Livro.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

enum TipoDeLivro: String, CaseIterable, Codable {
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

struct Preco: Codable {
    let valor: Decimal
    let tipoDeLivro: TipoDeLivro
    
    enum CodingKeys: String, CodingKey {
        case valor = "value"
        case tipoDeLivro = "bookType"
    }
}

struct Livro: Codable {
    let id: Int?
    let titulo: String
    let subtitulo: String
    let imagemDeCapaURI: URL
    let autor: Autor
    let precos: [Preco]
    let description: String?
    let isbn: String?
    let numberOfPages: Int?
    let publicationDate: String?
    
    init(id: Int? = nil, titulo: String, subtitulo: String, imagemDeCapaURI: URL, autor: Autor, precos: [Preco], description: String? = nil, isbn: String? = nil, numberOfPages: Int = 0, publicationDate: String? = nil) {
        self.id = id
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.imagemDeCapaURI = imagemDeCapaURI
        self.autor = autor
        self.precos = precos
        self.description = description
        self.isbn = isbn
        self.numberOfPages = numberOfPages
        self.publicationDate = publicationDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id, description, isbn, numberOfPages, publicationDate
        case titulo = "title"
        case subtitulo = "subtitle"
        case imagemDeCapaURI = "coverImagePath"
        case autor = "author"
        case precos = "prices"
    }
}

struct BookInput: Codable {
    let authorId: Int
    let title: String
    let subtitle: String
    let description: String
    let eBookPrice: Decimal
    let hardcoverPrice: Decimal
    let comboPrice: Decimal
    let coverImagePath: String
    let numberOfPages: Int
    let isbn: String
    let publicationDate: String
    
    init(authorId: Int, title: String, subtitle: String, description: String, eBookPrice: Decimal, hardcoverPrice: Decimal, comboPrice: Decimal, coverImagePath: String, numberOfPages: Int, isbn: String, publicationDate: String) {
        self.authorId = authorId
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.eBookPrice = eBookPrice
        self.hardcoverPrice = hardcoverPrice
        self.comboPrice = comboPrice
        self.coverImagePath = coverImagePath
        self.numberOfPages = numberOfPages
        self.isbn = isbn
        self.publicationDate = publicationDate
    }
    
}
