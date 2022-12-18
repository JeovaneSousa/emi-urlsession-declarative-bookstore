//
//  SectionTitleView.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

@IBDesignable class SectionTitleView: UIView {
    
    static let alturaBase: CGFloat = 48
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.texasRose.withAlphaComponent(0.75).cgColor
        return layer
    }()
    
    
    @IBInspectable var texto: String? {
        didSet {
            tituloLabel.text = texto
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addTheme()
        addViews()
        addConstraints()
    }
    
    private func addTheme() {
        backgroundColor = .white
        layer.insertSublayer(backgroundLayer, below: tituloLabel.layer)
    }
    
    private func addViews() {
        addSubview(tituloLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: Self.alturaBase)
        ])
        
        NSLayoutConstraint.activate([
            tituloLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tituloLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
    }

}

