//
//  Router.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 07.05.2021..
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func setTabBarController()
    func showQuizViewController(quiz: Quiz)
    func popToRoot()
    func popBack()
    func setStartScreen(window: UIWindow?)
}

class AppRouter: AppRouterProtocol {
        
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func popToRoot() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func popBack() {
        self.navigationController.popViewController(animated: true)
    }

    func setTabBarController() {
        let tabBarController = TabBarController(router: self)
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }

    func showQuizViewController(quiz: Quiz) {
        navigationController.pushViewController(QuizViewController(quiz: quiz, router: self), animated: true)
    }
    
    func setStartScreen(window: UIWindow?) {
        let loginController = LoginViewController(router: self)
        
        navigationController.pushViewController(loginController, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}
