//
//  TestController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 01.06.2021..
//

//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.04.2021..
//
import Foundation
import UIKit
import PureLayout
import CoreData
class QuizzesViewController1: UIViewController {
    
    private var router: AppRouterProtocol!
    private var popQuizLabel: UILabel!
    private var getButton: UIButton!
    private var funFactLabel: UILabel!
    private var infLabel: UILabel!
    private var quizzes: [Quiz]!
    private var tableView: UITableView!
    private var errView: UIView!
    private var xImgErr: UIImageView!
    private var errTitle: UILabel!
    private var errText: UILabel!
    private var nbacount:Int!
    private var sportQuizzes: [Quiz]!
    private var scienceQuizzes: [Quiz]!
    private let cellIdentifier = "cellId"
    private let headerIdentifier = "headerId"
    private let colorBackground = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
    private var gradientLayer: CAGradientLayer!
    private var quizCollectionView: QuizzesCollectionView!
    private var quizzesDict: [QuizCategory:[Quiz]] = [:]
    private var quizzesLogic: QuizzesLogic!
    var refreshControl: UIRefreshControl!
    
    convenience init(router: AppRouterProtocol, quizzesLogic: QuizzesLogic) {
        self.init()
        self.router = router
        self.quizzesLogic = quizzesLogic
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
          ]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        getQuizzes()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    private func buildViews() {
        popQuizLabel = UILabel()
        view.addSubview(popQuizLabel)
        popQuizLabel.text = "PopQuiz"
        popQuizLabel.textAlignment = .center
        popQuizLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        popQuizLabel.textColor = .white

        
        funFactLabel = UILabel()
        view.addSubview(funFactLabel)
        funFactLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        funFactLabel.textColor = .white
        funFactLabel.text = "Fun Fact"
        funFactLabel.isHidden=true
        
        infLabel = UILabel()
        view.addSubview(infLabel)
        infLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        infLabel.textColor = .white
        infLabel.numberOfLines = 0
        infLabel.isHidden=true
        
        quizCollectionView = QuizzesCollectionView(router: router)
        view.addSubview(quizCollectionView)
        quizCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        infLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel)
        infLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        infLabel.autoSetDimensions(to: CGSize(width: 350, height: 60))
        
        NSLayoutConstraint.activate([
            quizCollectionView.topAnchor.constraint(equalTo: infLabel.bottomAnchor, constant: 72),
            quizCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            quizCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            quizCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])

    }
    private func getQuizzes(){
        self.quizCollectionView.isHidden = false

            
        
        
    }

}
