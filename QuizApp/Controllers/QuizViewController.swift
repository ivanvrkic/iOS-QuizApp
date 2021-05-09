//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 08.05.2021..
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    private var quiz: Quiz!
    private var questionIndexLabel: UILabel!
    private var questionLabel: UILabel!
    private var questionIndex:Int=0
    private var questionTrackerView: QuestionTrackerView!
    private var quizButtons: [QuizButton]!
    private var correctAnswers: Int!
    private var router: AppRouterProtocol!
    private var gradientLayer: CAGradientLayer!
    convenience init (quiz: Quiz, router: AppRouterProtocol) {
        self.init()
        self.quiz = quiz
        self.correctAnswers = quiz.questions.count
        self.router = router
    }
    
    override func viewDidLoad() {
        buildNavbar()
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
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        questionTrackerView.setNeedsUpdateConstraints()
        setConstraints()
        gradientLayer.frame = view.bounds
    }
    
    private func buildNavbar() {
        let image = UIImage(systemName: "chevron.left")
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: image, style: .done, target: self, action: #selector(popBack))
        let popQuizLabel = UILabel()
        popQuizLabel.text = "PopQuiz"
        popQuizLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        popQuizLabel.textColor = .white
        navigationItem.titleView = popQuizLabel
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc
    func popBack() {
        router.popBack()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let offset: CGFloat = 0.025*max(view.frame.width, view.frame.height)
        NSLayoutConstraint.activate([
            questionIndexLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset),
            questionIndexLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            questionTrackerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0),
            questionTrackerView.topAnchor.constraint(equalTo: questionIndexLabel.bottomAnchor, constant: 5),
            questionTrackerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            questionTrackerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            questionLabel.topAnchor.constraint(equalTo: questionTrackerView.bottomAnchor, constant: 50),
            questionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
        for (i, quizButton) in quizButtons.enumerated() {
            NSLayoutConstraint.activate([quizButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)])
            NSLayoutConstraint.activate([quizButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)])
            if i==0 {
                NSLayoutConstraint.activate([quizButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 38)])
            } else {
                NSLayoutConstraint.activate([quizButton.topAnchor.constraint(equalTo: quizButtons[i-1].bottomAnchor, constant: 16)])
            }
        }
    }
    
    private func buildView() {
        questionIndexLabel=UILabel()
        questionIndexLabel.textColor = .white
        questionIndexLabel.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        questionLabel = UILabel()
        questionLabel.textColor = .white
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        
        questionTrackerView = QuestionTrackerView()
        questionTrackerView.set(numberOfQuestions: quiz.questions.count-1)
                
        addToSubview(component: questionIndexLabel)
        addToSubview(component: questionLabel)
        addToSubview(component: questionTrackerView)
        
        quizButtons=[]
        for _ in 0...3 {
            let button = QuizButton()
            button.addTarget(self, action: #selector(answerClicked(_:)), for: .touchUpInside)
            quizButtons.append(button)
            addToSubview(component: button)
        }
        
        displayQuestion(response: 0)
    }
    
    @objc
    private func answerClicked(_ sender:QuizButton) {
        let correctAnswer:Int=quiz.questions[questionIndex-1].correctAnswer
        quizButtons[correctAnswer].backgroundColor = UIColor(red: 0.435, green: 0.812, blue: 0.592, alpha: 1) // correct
        var response: Int = 1
        if correctAnswer != sender.getIndex() {
            quizButtons[sender.getIndex()].backgroundColor = UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1)  //incorrect
            self.correctAnswers-=1
            response = -1
        }
        for (_, quizButton) in quizButtons.enumerated() {
            quizButton.isEnabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.displayQuestion(response: response)
        }
    }
    
    private func displayQuestion(response: Int) {
        if questionIndex==quiz.questions.count {
            let controller = ResultViewController(correct: correctAnswers, total: quiz.questions.count, router: router)
            self.navigationController?.pushViewController(controller, animated: true)
            return
        }
        questionIndexLabel.text="\(questionIndex+1)/\(quiz.questions.count)"
        questionLabel.text=quiz.questions[questionIndex].question
        questionTrackerView.updateQuestion(index: questionIndex-1, response: response)
        
        for (i, answer) in quiz.questions[questionIndex].answers.enumerated() {
            quizButtons[i].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
            quizButtons[i].set(title: answer,index: i)
            quizButtons[i].isEnabled = true
        }
        questionIndex+=1
    }
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
    }
}

