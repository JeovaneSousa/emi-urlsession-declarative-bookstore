//
//  Theme.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import UIKit

protocol ThemeConfigurable: UIViewController {
    func applyTheme()
}

extension ThemeConfigurable {
    func applyTheme() {
        configureStatusBar()
        configureNavigationItem()
    }
    
    private func configureStatusBar() {
        navigationController?.setStatusBar(backgroundColor: .texasRose)
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func configureNavigationItem() {
        let logoImageView = UIImageView(image: .init(named: "LogoTypo"))
        logoImageView.tintColor = .white
        logoImageView.contentMode = .scaleAspectFit
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 176, height: 44))
        logoImageView.frame = titleView.bounds
        titleView.addSubview(logoImageView)
        
        navigationItem.titleView = titleView
    }
}

extension UIViewController: ThemeConfigurable {}

extension UINavigationController {
    fileprivate func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        
        view.addSubview(statusBarView)
    }
}

extension UIColor {
    static var texasRose: UIColor = .init(named: "Texas Rose") ?? .systemOrange
    static var pampas: UIColor = .init(named: "Pampas") ?? .tertiarySystemBackground
    static var rum: UIColor = .init(named: "Rum") ?? .secondarySystemBackground
    static var saffronMango: UIColor = .init(named: "Saffron Mango") ?? .systemYellow
}
