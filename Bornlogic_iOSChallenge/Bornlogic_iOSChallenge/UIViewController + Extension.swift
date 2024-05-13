//
//  UIViewController + Extension.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

extension UIViewController {
    public func configureNavBar(title: String) {
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
