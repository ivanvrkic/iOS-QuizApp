//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 04.05.2021..
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
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
        buildView()
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
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            usernameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            username.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            username.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            logOutButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            logOutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            logOutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func buildView() {
        usernameLabel = UILabel()
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        usernameLabel.text = "USERNAME"
        username = UILabel()
        username.textColor = .white
        username.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        username.text = "SportJunkie123"
        logOutButton = UIButton()
        logOutButton.backgroundColor = .white
        logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        logOutButton.layer.cornerRadius = 22
        
        addSubview(element: usernameLabel)
        addSubview(element: username)
        addSubview(element: logOutButton)
    }
    
    private func addSubview(element: UIView) {
        element.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(element)
    }
    
    @objc
    private func logOut(_:UIButton) {
        router.popToRoot()
    }
}
