//
//  CarrinhoViewController.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

class CarrinhoViewController: UIViewController {

    @IBOutlet private weak var produtosTableView: UITableView!
    @IBOutlet private weak var totalLabel: UILabel!
    
    var carrinho: Carrinho? {
        didSet {
            guard isViewLoaded, let carrinho = carrinho else { return }
            atualizaViews(com: carrinho)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        
        if let carrinho = carrinho {
            atualizaViews(com: carrinho)
        }
    }
    
    private func setupViews() {
        produtosTableView.register(CarrinhoSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: CarrinhoSectionHeaderView.reuseId)
        produtosTableView.sectionHeaderHeight = CarrinhoSectionHeaderView.alturaBase
        produtosTableView.sectionHeaderTopPadding = 0
    }
    
    private func atualizaViews(com carrinho: Carrinho) {
        produtosTableView.reloadData()
        totalLabel.text = NumberFormatter.formatToCurrency(decimal: carrinho.total)
    }

}

extension CarrinhoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrinho?.itens.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = tableView.dequeueReusableCell(withIdentifier: "ItemDeCompraTableViewCell", for: indexPath) as? ItemDeCompraTableViewCell else {
            fatalError("Não foi possível obter célula para o item de compra do carrinho")
        }
        
        celula.itemDeCompra = carrinho!.itens[indexPath.row]
        return celula
    }

}

extension CarrinhoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CarrinhoSectionHeaderView.reuseId) as? CarrinhoSectionHeaderView else {
            fatalError("Não foi possível obter view de header para a lista de itens de compra do carrinho")
        }
        
        headerView.titulo = "Seu carrinho de compras"
        return headerView
    }
    
}

