//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 08.05.2021..
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    private var resultLabel: UILabel!
    private var finishButton:UIButton!
    private var correct: Int!
    private var total: Int!
    private var router: AppRouterProtocol!
    private var gradientLayer: CAGradientLayer!
    convenience init (correct: Int, total: Int, router: AppRouterProtocol) {
        self.init()
        self.correct = correct
        self.total = total
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
        gradientLayer.frame = view.bounds
    }
    
    private func setConstraints() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            finishButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            finishButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            finishButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        resultLabel=UILabel()
        resultLabel.text="\(self.correct!)/\(self.total!)"
        resultLabel.textColor = .white
        resultLabel.font = UIFont.boldSystemFont(ofSize: 50)
        finishButton = UIButton()
        finishButton.setTitle("Finish Quiz", for: .normal)
        finishButton.setTitleColor(.purple, for: .normal)
        finishButton.backgroundColor = .white
        finishButton.addTarget(self, action: #selector(finish(_:)), for: .touchUpInside)
        finishButton.layer.cornerRadius = 22
        view.addSubview(resultLabel)
        view.addSubview(finishButton)
    }
    
    @objc
    private func finish(_ sender: UIButton) {
        router.setTabBarController()
    }
}
