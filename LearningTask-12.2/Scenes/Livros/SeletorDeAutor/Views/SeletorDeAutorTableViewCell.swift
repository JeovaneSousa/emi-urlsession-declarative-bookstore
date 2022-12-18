//
//  SeletorDeAutorTableViewCell.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import UIKit

class SeletorDeAutorTableViewCell: UITableViewCell {

    @IBOutlet private weak var radioImageView: UIImageView!
    @IBOutlet private weak var autorLabel: UILabel!
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    var autor: Autor? {
        didSet {
            guard let autor = autor else { return }
            
            autorLabel.text = autor.nomeCompleto
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        radioImageView.image = UIImage(systemName: "circle")
    }
    
    func markAsSelected(completionHandler: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.radioImageView.alpha = 0
            self?.layoutIfNeeded()
            
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0.1, animations: { [weak self] in
                self?.radioImageView.image = UIImage(systemName: "circle.inset.filled")
                
                self?.radioImageView.alpha = 1
                self?.layoutIfNeeded()
            }) { _ in
                completionHandler()
            }
        }
    }
    
}
