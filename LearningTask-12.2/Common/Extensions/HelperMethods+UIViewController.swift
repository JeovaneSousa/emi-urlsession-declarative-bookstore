//
//  HelperMethods+UIViewController.swift
//  LearningTask-12.2
//
//  Created by jeovane.barbosa on 13/01/23.
//

import Foundation
import UIKit

typealias MensagemDeValidacao = String

extension UIViewController {
    
    func nomeDeAutorValido(_ nome: String) -> Bool {
        let pattern = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: nome)
    }
    
    func isDateValid(_ date: String) -> Bool {
        let pattern = #"^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: date)
    }
    
    func separa(nomeDeAutor: String) -> (String, String) {
        let separador = " "
        let nomeCompleto = nomeDeAutor.components(separatedBy: separador)
        return (nomeCompleto.first!, nomeCompleto.dropFirst().joined(separator: separador))
    }
}
