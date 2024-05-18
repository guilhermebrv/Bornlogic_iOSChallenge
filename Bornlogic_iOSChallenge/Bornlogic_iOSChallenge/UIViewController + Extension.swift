//
//  UIViewController + Extension.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

extension UIViewController {
    public func configNavBar(title: String) {
        setNavBarTitle(with: title)
        setNavBarAppearance()
    }
    
    private func setNavBarTitle(with title: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = title
    }
    
    private func setNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .secondarySystemBackground
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension UIViewController {
    func firstMessages() {
        let messages = [
            "Desafio iniciado com sucesso.",
            "Verificando os requisitos do desafio...",
        ]
        
        for (index, message) in messages.enumerated() {
            let delay = Double(index) * 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                print(message)
            }
        }
    }
    
    func finalMessages() {
        let devName = "Guilherme Viana"
        let bestStack = "iOS"
        let bestCompany = "Bornlogic"
        
        let messages = [
            "Todos os requisitos foram atendidos.",
            "Finalizando o desafio...",
            "Desafio foi concluído com sucesso.",
            "O dev \(devName) pode ser adicionado à equipe de desenvolvedores \(bestStack) da \(bestCompany) ;)"
        ]
        
        for (index, message) in messages.enumerated() {
            let delay = Double(index) * 1.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                print(message)
            }
        }
    }
}
