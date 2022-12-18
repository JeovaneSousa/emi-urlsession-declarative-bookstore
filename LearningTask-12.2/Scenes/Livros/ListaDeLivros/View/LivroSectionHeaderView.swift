//
//  LivroSectionHeaderView.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class LivroSectionHeaderView: UICollectionReusableView {
    
    @IBOutlet private weak var sectionTitleView: SectionTitleView!
    
    var titulo: String? {
        didSet {
            sectionTitleView.texto = titulo
        }
    }
}

