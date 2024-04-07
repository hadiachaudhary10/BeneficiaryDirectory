//
//  SceneDelegate.swift
//  BeneficiariesTestProject
//
//  Created by Dev on 15/03/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        let controller = BeneficiaryListViewController()
        let navController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navController
    }
}

