//
//  TabBarController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 04.05.2021..
//
import Foundation
import UIKit

class TabBarController: UITabBarController {
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
        buildViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func buildViews() {
        let quizImage = UIImage(systemName: "clock")
        let searchImage = UIImage(systemName: "magnifyingglass")
        let settingsImage = UIImage(systemName: "gearshape.fill")
        
        let quizController = QuizzesViewController(router: router)
        quizController.tabBarItem = UITabBarItem(title: "Quiz", image: quizImage, selectedImage: nil)
        
        let searchController = SearchViewController(router: router)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: searchImage, selectedImage:
        nil)
        
        let settingsController = SettingsViewController(router: router)
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: settingsImage, selectedImage:
        nil)
        
        self.tabBar.tintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
        self.tabBar.barTintColor = .white
        self.viewControllers = [quizController, searchController, settingsController]
    }
}
