//
//  ItemDeCompraTableViewCell.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class ItemDeCompraTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var fotoDeCapaImageView: UIImageView!
    @IBOutlet private weak var tituloLabel: UILabel!
    @IBOutlet private weak var nomeDoAutorLabel: UILabel!
    @IBOutlet private weak var tipoDeLivroLabel: UILabel!
    @IBOutlet private weak var precoLabel: UILabel!
    
    var itemDeCompra: ItemDeCompra? {
        didSet {
            guard let itemDeCompra = itemDeCompra else { return }
            let livro = itemDeCompra.livro
            
            fotoDeCapaImageView.setImageByDowloading(url: livro.imagemDeCapaURI,
                                                     placeholderImage: .init(named: "Book"))
            tituloLabel.text = livro.titulo
            nomeDoAutorLabel.text = livro.autor.nomeCompleto
            tipoDeLivroLabel.text = itemDeCompra.tipoDeLivro.titulo
            precoLabel.text = NumberFormatter.formatToCurrency(decimal: itemDeCompra.preco)
        }
    }
    
}

