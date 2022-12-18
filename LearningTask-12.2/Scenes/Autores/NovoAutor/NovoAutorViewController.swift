//
//  NovoAutorViewController.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

protocol NovoAutorViewControllerDelegate: AnyObject {
    func novoAutorViewController(_ controller: NovoAutorViewController, adicionou autor: Autor)
}

class NovoAutorViewController: UIViewController {

    typealias MensagemDeValidacao = String
    
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var fotoTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var tecnologiasTableView: UITableView!
    
    var autoresAPI: AutoresAPI?
    
    weak var delegate: NovoAutorViewControllerDelegate?
    
    var tecnologias: [String] = [] {
        didSet {
            tecnologiasTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fotoTextFieldEditingDidEnd(_ sender: UITextField) {
        guard let urlString = sender.text, let url = URL(string: urlString) else {
            return
        }
        
        fotoImageView.setImageByDowloading(url: url,
                                           placeholderImage: .init(named: "Avatar"),
                                           animated: true)
    }
    
    @IBAction func botaoSalvarPressionado(_ sender: UIButton) {
        switch formularioEhValido() {
            
        case (false, let mensagem):
            UIAlertController.showError(mensagem!, in: self)
            
        default:
            cadastraAutor()
        }
    }
    
    private func nomeDeAutorValido(_ nome: String) -> Bool {
        let pattern = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: nome)
    }
    
    private func separa(nomeDeAutor: String) -> (String, String) {
        let separador = " "
        let nomeCompleto = nomeDeAutor.components(separatedBy: separador)
        return (nomeCompleto.first!, nomeCompleto.dropFirst().joined(separator: separador))
    }
    
    private func formularioEhValido() -> (Bool, MensagemDeValidacao?) {
        guard let urlString = fotoTextField.text,
              let _ = URL(string: urlString) else {
            return (false, "Informe a URL da foto do autor")
        }
        
        guard let nome = nomeTextField.text, !nome.isEmpty else {
            return (false, "Nome não pode estar em branco")
        }

        guard nomeDeAutorValido(nome) else {
            return (false, "Informe o nome completo do autor.")
        }
        
        if let bio = bioTextField.text, bio.isEmpty {
            return (false, "A bio do autor não pode estar em branco")
        }
        
        if tecnologias.isEmpty {
            return (false, "Informe ao menos uma tecnologia sobre a qual este autor escreve.")
        }
        
        return (true, nil)
    }
    
    func cadastraAutor() {
        let (nome, sobrenome) = separa(nomeDeAutor: nomeTextField.text!)
        let autor = Autor(foto: URL(string: fotoTextField.text!)!,
                          nome: nome,
                          sobrenome: sobrenome,
                          bio: bioTextField.text!,
                          tecnologias: tecnologias)
        
        autoresAPI?.registraNovo(autor, completionHandler: { [weak self] novoAutor in
            self?.dismiss(animated: true) {
                self?.delegate?.novoAutorViewController(self!, adicionou: novoAutor)
            }
            
        }, failureHandler: { [weak self] erro in
            debugPrint(erro)
            
            let mensagem = "Não foi possível adicionar autor. \(erro.localizedDescription)"
            UIAlertController.showError(mensagem, in: self!)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verCampoNovaTecnologiaSegue" else { return }
        
        guard let destinationController = segue.destination as? NovaTecnologiaViewController else {
            fatalError("Não foi possível executar segue \(segue.identifier!)")
        }
        
        destinationController.delegate = self
    }

}

// MARK: - Handles NovaTecnologiaViewController delegation
extension NovoAutorViewController: NovaTecnologiaViewControllerDelegate {
   
    func novaTecnologiaViewController(_ controller: NovaTecnologiaViewController, adicionou tecnologia: String) {
        tecnologias.append(tecnologia)
    }
    
}

// MARK: - TableView Data Source implementations
extension NovoAutorViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tecnologias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = tableView.dequeueReusableCell(withIdentifier: "TecnologiaViewCell", for: indexPath) as? TecnologiaViewCell else {
            fatalError("Não foi possível obter célula para a tecnologia do autor em NovoAutor")
        }
        
        celula.tecnologia = tecnologias[indexPath.row]
        return celula
    }
    
}
