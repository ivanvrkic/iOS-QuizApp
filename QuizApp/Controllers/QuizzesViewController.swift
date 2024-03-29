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
class QuizzesViewController: UIViewController {
    
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

        errView = UIView()
        view.addSubview(errView)
        xImgErr = UIImageView(image: UIImage(systemName: "xmark.circle"))
        xImgErr.contentMode = .scaleToFill
        xImgErr.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        errView.addSubview(xImgErr)
        errTitle = UILabel()
        errTitle.text = "Error"
        errTitle.textColor = .white
        errTitle.textAlignment = .center
        errTitle.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.black)
        errView.addSubview(errTitle)
        errText = UILabel()
        errText.numberOfLines = 0
        errText.textAlignment = .center
        errText.textColor = .white
        errText.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        errText.text = "Data can't be reached.\nPlease try again"
        errView.addSubview(errText)
        
        
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
        popQuizLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        popQuizLabel.autoSetDimension(.width, toSize: 200)
        popQuizLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
//        getButton.autoPinEdge(.top, to: .bottom, of: , withOffset: 15)
//        getButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
//        getButton.autoAlignAxis(toSuperviewAxis: .vertical)
        
        errView.autoPinEdge(.top, to: .bottom, of: popQuizLabel, withOffset: 10)
        errView.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: 30)
        errView.autoPinEdge(toSuperviewSafeArea: .leading)
        errView.autoAlignAxis(toSuperviewAxis: .vertical)
    
        errText.autoCenterInSuperview()
        errText.autoPinEdge(.top, to: .bottom, of: errTitle, withOffset: 15)
        errText.autoAlignAxis(toSuperviewAxis: .vertical)
        errTitle.autoPinEdge(.bottom, to: .top, of: errText, withOffset: -15)
        errTitle.autoSetDimension(.width, toSize: 200)
        errTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        xImgErr.autoPinEdge(.bottom, to: .top, of: errTitle, withOffset: -10)
        xImgErr.autoSetDimensions(to: CGSize(width: 80, height: 80))
        xImgErr.autoAlignAxis(toSuperviewAxis: .vertical)
        
        funFactLabel.autoPinEdge(.top, to: .bottom, of: popQuizLabel, withOffset: 10)
        funFactLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        funFactLabel.autoSetDimension(.height, toSize: 40)
        
        infLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel)
        infLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        infLabel.autoSetDimensions(to: CGSize(width: 350, height: 60))
        
        NSLayoutConstraint.activate([
            quizCollectionView.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor, constant: 72),
            quizCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            quizCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            quizCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])

    }
    private func getQuizzes(){
        do {
            try quizzesLogic.refreshQuizzes()
            quizzes = quizzesLogic.filterQuizzes(filter: FilterSettings(searchText: ""))
            self.quizzesDict = quizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                    a, b in
                        var map:[QuizCategory: [Quiz]] = a
                        var value = map[b.category,default: []]
                        value.append(b)
                        map[b.category] = value
                        return map
                }
            )
            self.errView.isHidden = true
            self.nbacount = quizzes.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count
            self.funFactLabel.isHidden=false
            self.infLabel.isHidden=false
            self.infLabel.text = "There are \(self.nbacount!) questions that contain the word NBA"
            self.quizzesDict = quizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                    a, b in
                        var map:[QuizCategory: [Quiz]] = a
                        var value = map[b.category,default: []]
                        value.append(b)
                        map[b.category] = value
                        return map
                }
            )
            self.quizCollectionView.isHidden = false
            self.quizCollectionView.addQuizzes(quizzes: self.quizzesDict)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
            
        
        
    }

}
