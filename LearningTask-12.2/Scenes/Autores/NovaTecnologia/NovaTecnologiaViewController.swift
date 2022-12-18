//
//  NovaTecnologiaViewController.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

protocol NovaTecnologiaViewControllerDelegate: AnyObject {
    func novaTecnologiaViewController(_ controller: NovaTecnologiaViewController, adicionou tecnologia: String)
}

class NovaTecnologiaViewController: UIViewController {
    
    typealias MensagemDeValidacao = String

    @IBOutlet weak var tecnologiaTextField: UITextField!
    
    weak var delegate: NovaTecnologiaViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func botaoAdicionarPressionado(_ sender: UIButton) {
        switch formularioEhValido() {
            
        case (false, let mensagem):
            UIAlertController.showError(mensagem!, in: self)
            
        default:
            adicionaTecnologia()
        }
    }
    
    func formularioEhValido() -> (Bool, MensagemDeValidacao?) {
        if let tecnologia = tecnologiaTextField.text, tecnologia.isEmpty {
            return (false, "Informe a tecnologia para o autor.")
        }
        
        return (true, nil)
    }
    
    func adicionaTecnologia() {
        delegate?.novaTecnologiaViewController(self, adicionou: tecnologiaTextField.text!)
        self.dismiss(animated: true)
    }
    
}
