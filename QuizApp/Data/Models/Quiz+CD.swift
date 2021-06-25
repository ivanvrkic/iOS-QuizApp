//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

import Foundation
import UIKit
import CoreData

extension Quiz {
    
    init(with entity: CDQuiz) {
        id = Int(entity.identifier)
        title = entity.title
        description = entity.desc
        category = QuizCategory.init(rawValue: entity.category)!
        level = Int(entity.level)
        imageUrl = entity.imageUrl
        var questions1: [Question] = []
        entity.questions.forEach { cdQuestion in
            let question = Question(with: cdQuestion as! CDQuestion)
            questions1.append(question)
        }
        questions = questions1
    }

    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.identifier = Int32(id)
        entity.title = title
        entity.desc = description
        entity.category = category.rawValue
        entity.level = Int32(level)
        entity.imageUrl = imageUrl
        var cdQuestions: [CDQuestion] = []
        for question in questions {
            let cdQuestion = CDQuestion(context: context)
            question.populate(cdQuestion)
            cdQuestions.append(cdQuestion)
        }
        entity.questions = NSSet(array: cdQuestions)
    }

}
