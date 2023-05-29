//
//  NovoLivroViewController.swift
//  LearningTask-12.2
//
//  Created by jeovane.barbosa on 13/01/23.
//

import UIKit

protocol NovoLivroViewControllerDelegate: AnyObject {
    func NovoLivroViewController(viewController: UIViewController, adicionou livro: Livro)
}

class NovoLivroViewController: UIViewController {
    
    @IBOutlet weak var capaDoLivroImageView: UIImageView!
    @IBOutlet weak var fotoDaCapaTextField: UITextField!
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var subtituloTextField: UITextField!
    @IBOutlet weak var autorTextField: UITextField!
    @IBOutlet weak var descricaoTextView: UITextView!
    
    @IBOutlet weak var precoEbookTextField: UITextField!
    @IBOutlet weak var precoImpressoTextField: UITextField!
    @IBOutlet weak var precoComboTextField: UITextField!
    
    @IBOutlet weak var numeroDePaginasTextField: UITextField!
    @IBOutlet weak var ISBNTextField: UITextField!
    @IBOutlet weak var dataDePublicacaoTextField: UITextField!
    
    var livrosApi: LivrosAPI?
    var autor: Autor?
    weak var delegate: NovoLivroViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isFormValid() -> (Bool, MensagemDeValidacao) {
        guard let fotoText = fotoDaCapaTextField.text,
              let _ = URL(string: fotoText) else {
            return (false, "Informe a URL da foto do livro.")
        }
        
        guard let titulo = tituloTextField.text, !titulo.isEmpty else {
            return(false, "Informe o título do livro.")
        }
        
        guard let subtitulo = subtituloTextField.text, !subtitulo.isEmpty else {
            return (false, "Informe o subtitulo do livro.")
        }
        
        guard let nome = autorTextField.text, !nome.isEmpty else {
            return (false, "Nome do autor não pode estar em branco.")
        }
        
        guard nomeDeAutorValido(nome) else {
            return (false, "Preencha o nome completo do autor.")
        }
        
        guard let descricao = descricaoTextView.text, !descricao.isEmpty, descricao != "Descrição do livro" else {
            return (false, "Preencha a descrição do livro.")
        }
        
        guard let precoEbook = precoEbookTextField.text, !precoEbook.isEmpty else {
            return (false, "Informe o preço do Ebook.")
        }
        
        guard let precoImpresso = precoImpressoTextField.text, !precoImpresso.isEmpty else {
            return (false, "Informe o preço do livro Impresso.")
        }
        
        guard let combo = precoComboTextField.text, !combo.isEmpty else {
            return (false, "Informe o preço do combo.")
        }
        
        guard let numeroDePaginas = numeroDePaginasTextField.text, !numeroDePaginas.isEmpty else {
            return (false, "Preencha o número de páginas.")
        }
        
        guard let _ = Int(numeroDePaginas) else {
            return (false, "O número de páginas não é válido.")
        }
        
        guard let isbn = ISBNTextField.text, !isbn.isEmpty else {
            return (false, "Preencha o número ISBN.")
        }
        
        guard let dataDePublicacao = dataDePublicacaoTextField.text, !dataDePublicacao.isEmpty else {
            return (false, "Preencha a data de publicação.")
        }
        
        guard isDateValid(dataDePublicacao) else {
            return (false, "Data preenchida não é válida.")
        }
    
        return (true, "")
    }
    
    func cadastraLivro() {
        
        let livro = BookInput(authorId: (self.autor?.id)!,
                              title: tituloTextField.text!,
                              subtitle: subtituloTextField.text!,
                              description: descricaoTextView.text!,
                              eBookPrice: NSDecimalNumber(string: precoEbookTextField.text!) as Decimal,
                              hardcoverPrice: NSDecimalNumber(string: precoImpressoTextField.text!) as Decimal,
                              comboPrice: NSDecimalNumber(string: precoComboTextField.text!) as Decimal,
                              coverImagePath: fotoDaCapaTextField.text!,
                              numberOfPages: Int(numeroDePaginasTextField.text!)!,
                              isbn: ISBNTextField.text!,
                              publicationDate: dataDePublicacaoTextField.text!)
        
        livrosApi?.registraNovo(livro: livro, completionHandler: { [weak self] result in
            switch result {
                
            case .success(let livro):
                self?.dismiss(animated: true, completion: {
                    self?.delegate?.NovoLivroViewController(viewController: self!, adicionou: livro)
                })
                
                
            case .failure(let error):
                let mensagem = """
                    Não foi possível registrar um novo autor: \(error.description)
                    """
                
                guard let self = self else {return}
                UIAlertController.showError(mensagem, in: self)
            }
            
        })
    }
    
    @IBAction func fotoDaCapaTextFieldEditingDidEnd(_ sender: UITextField) {
        guard let text = sender.text, let url = URL(string:text) else {return}
        
        capaDoLivroImageView.setImageByDowloading(url: url,
                                            placeholderImage: .init(named: "Book"),
                                            animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "verSeletorDeAutorViewControllerSegue" else {return}
        
        guard let seletorDeAutorViewController = segue.destination as? SeletorDeAutorViewController else {
            fatalError("Unable to acquire necessary data to perform segue with identifier: \(String(describing: segue.identifier))")
        }
        
        seletorDeAutorViewController.delegate = self
        seletorDeAutorViewController.autoresAPI = AutoresAPI()
        
    }
    
    @IBAction func autorDoLivroTextFieldEditingDidBegin(_ sender: UITextField) {
        performSegue(withIdentifier: "verSeletorDeAutorViewControllerSegue", sender: self)
    }
    
    @IBAction func adicionarLivroButtonPressed(_ sender: UIButton) {
        switch isFormValid() {
            
        case (false, let message):
            UIAlertController.showError(message, in: self)
            
        case (true, _):
            cadastraLivro()
        }
    }
}

//MARK: - Implements SeletorDeAutorViewControllerDelegate
extension NovoLivroViewController: SeletorDeAutorViewControllerDelegate {
    func seletorDeAutorViewController(_ controller: SeletorDeAutorViewController, selecionouAutor autor: Autor) {
        autorTextField.text = autor.nomeCompleto
        self.autor = autor
    }
    
    
}

//MARK: - UITextViewDelegate Implementation
extension NovoLivroViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let placeHolder = "Descrição do livro"
        if textView.text == placeHolder {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Descrição do livro"
        }
    }
}
