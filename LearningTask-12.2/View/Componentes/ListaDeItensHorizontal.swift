//
//  ListaDeItensHorizontal.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

// MARK: - Componente
@IBDesignable class ListaDeItensHorizontal: UIView {
    
    // MARK: Subviews
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ItemViewCell.self,
                                forCellWithReuseIdentifier: ItemViewCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    private lazy var containerView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [
            tituloLabel,
            collectionView,
        ])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 8
        return stackview
    }()
    
    // MARK: Propriedades
    
    private var _itens: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Inicializacao
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        addSubview(containerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    // MARK: API pública
    var titulo: String? {
        didSet {
            guard let titulo = titulo else { return }
            tituloLabel.text = titulo
            tituloLabel.isHidden = false
        }
    }
    
    var corDoTitulo: UIColor? {
        didSet {
            tituloLabel.textColor = corDoTitulo
        }
    }
    
    var itens: [String]? {
        didSet {
            guard let itens = itens else { return }
            self._itens = itens
        }
    }
    
}

// MARK: - Gestão da fonte de dados
extension ListaDeItensHorizontal: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _itens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemViewCell.reuseId, for: indexPath) as? ItemViewCell else {
            fatalError("Não foi possível obter a celula para a lista de itens horizontal")
        }
    
        cell.item = _itens[indexPath.row]
        return cell
    }
        
}

extension ListaDeItensHorizontal: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let defaultSize = CGSize(width: 100, height: collectionView.bounds.height)
        
        let item = _itens[indexPath.row]
        
        guard let size = ItemViewCell.calculateMinCellSize(for: item, in: collectionView) else {
            return defaultSize
        }

        return size
    }
}
    
fileprivate class ItemViewCell: UICollectionViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
    
    private static let font: UIFont = .systemFont(ofSize: 12, weight: .light)
    
    // MARK: subviews
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        label.font = ItemViewCell.font
        return label
    }()
    
    // MARK: inicialização
    
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
        backgroundColor = .texasRose
        layer.cornerRadius = 8
    }
    
    private func addViews() {
        addSubview(label)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    fileprivate static func calculateMinCellSize(for label: String, in parent: UIView) -> CGSize? {
        let horizontalPadddingSize: CGFloat = 16
        let fontAttributes = [NSAttributedString.Key.font: ItemViewCell.font]
        
        let size = (label as NSString).size(withAttributes: fontAttributes)
        let adjustedWidth = size.width + horizontalPadddingSize * 2
        
        return CGSize(width: adjustedWidth, height: parent.bounds.height)
    }
    
    // MARK: API pública
    var item: String? {
        didSet {
            label.text = item
        }
    }
    
}

