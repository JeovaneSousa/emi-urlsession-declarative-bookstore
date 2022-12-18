//
//  AutoresListViewController.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class AutoresListViewController: UITableViewController {
    
    private enum Segues: String {
        case verDetalhesDoAutor = "verDetalhesDoAutorSegue"
        case verFormNovoAutor = "verFormNovoAutorSegue"
    }

    var autoresAPI: AutoresAPI?
    var livrosAPI: LivrosAPI?
    
    var autores: [Autor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        // Do any additional setup after loading the view.
    
        setupViews()
        carregaAutores()
    }

    private func setupViews() {
        tableView.register(TableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TableSectionHeaderView.reuseId)
        tableView.sectionHeaderHeight = TableSectionHeaderView.alturaBase
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func carregaAutores() {
        autoresAPI?.listaTodos(completionHandler: { [weak self] autores in
            self?.autores = autores
            self?.tableView.reloadData()
            
        }, failureHandler:{ error in
            let mensagem = """
                Não foi possível carregar autores.
                \(error.localizedDescription)
            """
            
            UIAlertController.showError(mensagem, in: self)
        })
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueId = segue.identifier,
              let expectedSegue = AutoresListViewController.Segues(rawValue: segueId) else { return }
    
        switch expectedSegue {
        case .verDetalhesDoAutor:
            prepareForDetalhesDoAutor(segue, sender)
        case .verFormNovoAutor:
            prepareForFormNovoAutor(segue, sender)
        }
    }
    
    private func prepareForDetalhesDoAutor(_ segue: UIStoryboardSegue, _ sender: Any?) {
        guard let celula = sender as? AutorTableViewCell,
              let autorViewController = segue.destination as? AutorViewController else {
            fatalError("Não foi possível executar segue \(segue.identifier!)")
        }
    
        autorViewController.livrosAPI = livrosAPI
        autorViewController.autor = celula.autor
    }
    
    private func prepareForFormNovoAutor(_ segue: UIStoryboardSegue, _ sender: Any?) {
        guard let novoAutorViewController = segue.destination as? NovoAutorViewController else {
            fatalError("Não foi possível executar segue \(segue.identifier!)")
        }
    
        novoAutorViewController.delegate = self
        novoAutorViewController.autoresAPI = autoresAPI
    }
    
}

// MARK: - NovoAutor delegation implementations
extension AutoresListViewController: NovoAutorViewControllerDelegate {
    func novoAutorViewController(_ controller: NovoAutorViewController, adicionou autor: Autor) {
        autores.append(autor)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}

// MARK: - UITableViewDataSource Implementations
extension AutoresListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutorTableViewCell", for: indexPath) as? AutorTableViewCell else {
            fatalError("Não foi possível obter celula para a lista de autores")
        }
        
        let autor = autores[indexPath.row]
        cell.autor = autor
        
        return cell
    }
    
    var lastIndexPath: IndexPath {
        return .init(row: autores.count - 1, section: .zero)
    }
    
}

// MARK: - UITableViewDelegate Implementations
extension AutoresListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeaderView.reuseId) as? TableSectionHeaderView else {
            fatalError("Não foi possível obter view de header para a lista de autores.")
        }
        
        headerView.titulo = "Todos os Autores"
        return headerView
    }
    
}
