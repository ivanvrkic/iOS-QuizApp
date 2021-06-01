//
//  Question+CD.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 01.06.2021..
//

import Foundation

extension Question {
    
    init(with entity: CDQuestion) {
        id = Int(entity.identifier)
        question = entity.question
        answers = entity.answers!
        correctAnswer = Int(entity.correctAnswer)
    }

    func populate(_ entity: CDQuestion) {
        entity.identifier = Int32(id)
        entity.question = question
        entity.answers = answers
        entity.correctAnswer = Int32(correctAnswer)
    }


}
