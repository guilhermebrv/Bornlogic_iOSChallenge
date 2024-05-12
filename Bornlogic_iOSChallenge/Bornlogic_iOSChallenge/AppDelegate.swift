//
//  AppDelegate.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 12/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let newsList = NewsListViewController()
        displayScreen(newsList)
        
        return true
    }

}

extension AppDelegate {
    private func displayScreen(_ viewController: UIViewController) {
        setRootViewController(viewController, animated: true)
    }
    
    private func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = UINavigationController(rootViewController: viewController)
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

