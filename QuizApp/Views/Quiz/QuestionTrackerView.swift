//
//  QuestionTrackerView.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 08.05.2021..
//
import Foundation
import UIKit

class QuestionTrackerView: UIView {
    private var numberOfQuestions: Int = 0
    private var QuestionTrack: [UIView] = []
    private var stackView: UIStackView!
    
    private func buildView() {
        stackView = UIStackView()
        stackView.axis = .horizontal // 1.
        stackView.alignment = .fill // 2.
        stackView.distribution = .fillEqually// 3.
        stackView.spacing=7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        for _ in 0...numberOfQuestions {
            let rectangle = UIView()
            rectangle.layer.cornerRadius = 2.5
            rectangle.backgroundColor = .gray
            QuestionTrack.append(rectangle)
            rectangle.heightAnchor.constraint(equalToConstant: 5).isActive = true
            rectangle.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(rectangle)
        }
    }
      
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 3),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -2)
        ])
    }
    
    public func set(numberOfQuestions: Int) {
        self.numberOfQuestions = numberOfQuestions
        buildView()
        setConstraints()
    }
    
    public func updateQuestion(index: Int, response: Int) {
        if response != 0 {
            if response == 1 {
                QuestionTrack[index].backgroundColor = .green
            } else {
                QuestionTrack[index].backgroundColor = .red
            }
        }
        if (index+1) < numberOfQuestions {
            QuestionTrack[index+1].backgroundColor = .white
        }
    }
    
}
