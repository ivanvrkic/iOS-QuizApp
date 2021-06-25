//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 04.05.2021..
//

import Foundation
import UIKit
import CoreData

class SearchViewController: UIViewController {
    private var searchTextField: UITextField!
    private var searchView: UIView!
    private var searchButton: UIButton!
    private var quizCollectionView: QuizzesCollectionView!
    private var router: AppRouterProtocol!
    private var gradientLayer: CAGradientLayer!
    private var quizzesLogic: QuizzesLogic!
    var refreshControl: UIRefreshControl!
    private var quizzes: [Quiz]!
    private var quizzesDict: [QuizCategory:[Quiz]] = [:]
    
    convenience init(router: AppRouterProtocol, quizzesLogic: QuizzesLogic) {
        self.init()
        self.router = router
        self.quizzesLogic = quizzesLogic
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
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            searchButton.widthAnchor.constraint(equalToConstant: 60),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),

            searchView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            searchView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -5),
            searchView.heightAnchor.constraint(equalToConstant: 44),
            
            searchTextField.centerXAnchor.constraint(equalTo: searchView.centerXAnchor),
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            quizCollectionView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 72),
            quizCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            quizCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            quizCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
    }
    
    private func buildViews() {
        searchView = UIView()
        searchTextField = UITextField()
        view.addSubview(searchView)
        
        searchTextField.bounds.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        searchTextField.addTarget(self, action: #selector(focus), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(unfocus), for: .editingDidEnd)
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Type here", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchTextField.textColor = .white
        searchTextField.tintColor = .white
        searchTextField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        searchTextField.autocapitalizationType = .none
        searchView.layer.cornerRadius = 20
        searchView.clipsToBounds = true
        searchView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        searchView.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchButton = UIButton()
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .clear
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        
        quizCollectionView = QuizzesCollectionView(router: router)
        view.addSubview(quizCollectionView)
        quizCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    private func search() {
        do {
            try quizzesLogic.refreshQuizzes()
            quizzes = quizzesLogic.filterQuizzes(filter: FilterSettings(searchText: searchTextField.text ?? ""))
            quizzesDict = quizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                    a, b in
                        var map:[QuizCategory: [Quiz]] = a
                        var value = map[b.category,default: []]
                        value.append(b)
                        map[b.category] = value
                        return map
                }
            )
            self.quizCollectionView.isHidden = false
            self.quizCollectionView.addQuizzes(quizzes: quizzesDict)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    
    @objc
    private func focus() {
        searchView.layer.borderColor = UIColor.white.cgColor
        searchView.layer.masksToBounds = true
        searchView.layer.borderWidth = 1
        
    }
    
    @objc
    private func unfocus() {
        searchView.layer.borderWidth = 0
    }
    
}
