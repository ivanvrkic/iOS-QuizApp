//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 04.05.2021..
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    private var usernameLabel: UILabel!
    private var username: UILabel!
    private var logOutButton: UIButton!
    private var router: AppRouterProtocol!
    private var gradientLayer: CAGradientLayer!
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        buildViews()
        setConstraints()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
          ]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
        gradientLayer.frame = view.bounds
    }
        
    private func setConstraints() {
    }
    
    private func buildViews() {

    }
}
