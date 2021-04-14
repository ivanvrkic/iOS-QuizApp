//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.04.2021..
//
import Foundation
import UIKit
import PureLayout

class QuizzesViewController: UIViewController {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildFirstViews()
        addFirstConstraints()
        
    }
    
    private func buildFirstViews() {
        self.view.setBackground()
        popQuizLabel = UILabel()
        view.addSubview(popQuizLabel)
        popQuizLabel.text = "PopQuiz"
        popQuizLabel.textAlignment = .center
        popQuizLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.black)
        popQuizLabel.textColor = .white
        getButton = UIButton()
        view.addSubview(getButton)
        getButton.setTitle("Get Quiz", for: .normal)
        getButton.setTitleColor(.black, for: .normal)
        getButton.layer.cornerRadius = 25
        getButton.backgroundColor = .white
        getButton.addTarget(self, action: #selector(getQuiz), for: .touchUpInside)
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
    }
    
    private func addFirstConstraints() {
        
        popQuizLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        popQuizLabel.autoSetDimension(.width, toSize: 200)
        popQuizLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        getButton.autoPinEdge(.top, to: .bottom, of: popQuizLabel, withOffset: 15)
        getButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
        getButton.autoAlignAxis(toSuperviewAxis: .vertical)
        
        errView.autoPinEdge(.top, to: .bottom, of: getButton, withOffset: 10)
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

    }
    
    @objc
    private func getQuiz(){
        
        errView.isHidden = true
        
        let dataService =  DataService()
        quizzes = dataService.fetchQuizes()
        nbacount = quizzes.flatMap{$0.questions}.filter{$0.question.contains("NBA")}.count
        sportQuizzes = quizzes.filter{ $0.category == QuizCategory.sport }
        scienceQuizzes = quizzes.filter{ $0.category == QuizCategory.science }
        
        buildQuizView()
        addQuizConstraints()
        
    }
    
    private func buildQuizView(){
        
        //Fun Fact Title and bulb image
        funFactLabel = UILabel()
        view.addSubview(funFactLabel)
        funFactLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.black)
        funFactLabel.textColor = .white
        funFactLabel.text = "Fun Fact"
        // Fun Fact Label
        infLabel = UILabel()
        view.addSubview(infLabel)
        infLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        infLabel.textColor = .white
        infLabel.numberOfLines = 0
        infLabel.text = "There are \(nbacount!) questions that contain the word NBA"
        
        
    }
    
    private func addQuizConstraints(){
        funFactLabel.autoPinEdge(.top, to: .bottom, of: getButton, withOffset: 10)
        funFactLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        funFactLabel.autoSetDimension(.height, toSize: 40)
        
        infLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel)
        infLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        infLabel.autoSetDimensions(to: CGSize(width: 350, height: 60))
        

    }
}
