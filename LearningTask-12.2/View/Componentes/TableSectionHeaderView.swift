//
//  TableSectionHeaderView.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class TableSectionHeaderView: UITableViewHeaderFooterView {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
    static var alturaBase: CGFloat {
        return SectionTitleView.alturaBase
    }
    
    private lazy var sectionTitleView: SectionTitleView = {
        let view = SectionTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titulo: String? {
        didSet {
            sectionTitleView.texto = titulo
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addTheme()
        addViews()
        addConstraints()
    }
    
    private func addTheme() {
        contentView.backgroundColor = .texasRose.withAlphaComponent(0.75)
    }
    
    private func addViews() {
        addSubview(sectionTitleView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Self.alturaBase)
        ])
        
        NSLayoutConstraint.activate([
            sectionTitleView.topAnchor.constraint(equalTo: self.topAnchor),
            sectionTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sectionTitleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}

