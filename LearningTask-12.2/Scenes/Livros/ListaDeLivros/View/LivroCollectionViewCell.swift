//
//  LivroCollectionViewCell.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var capaImageView: UIImageView!
    @IBOutlet private weak var tituloLabel: UILabel!
    
    private var firstRender: Bool = true
   
    var livro: Livro? {
        didSet {
            guard let livro = livro else { return }

            capaImageView.setImageByDowloading(url: livro.imagemDeCapaURI,
                                               placeholderImage: .init(named: "Book"),
                                               animated: firstRender)
            tituloLabel.text = livro.titulo
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        firstRender = false
    }
}

