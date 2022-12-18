//
//  Carrinho.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

struct ItemDeCompra {
    let livro: Livro
    let tipoDeLivro: TipoDeLivro
    
    var preco: Decimal {
        return livro.precos
            .filter { $0.tipoDeLivro == tipoDeLivro }
            .map { $0.valor }
            .reduce(.zero, +)
    }
}

struct Carrinho {
    private(set) var itens: [ItemDeCompra] = []
    
    var total: Decimal {
        return itens
            .map { $0.preco }
            .reduce(.zero, +)
    }
    
    mutating func adiciona(_ item: ItemDeCompra) {
        itens.append(item)
    }
    
    static func constroi(com livro: Livro, doTipo tipoDeLivro: TipoDeLivro) -> Carrinho {
        let item = ItemDeCompra(livro: livro, tipoDeLivro: tipoDeLivro)
        return .init(itens: [item])
    }
}
