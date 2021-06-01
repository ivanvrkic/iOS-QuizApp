//
//  QuizResult.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation

struct QuizResult: Codable {
    
    var userId: Int
    var quizId: Int
    var time: Double
    var correctAnswers: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case quizId = "quiz_id"
        case time
        case correctAnswers = "no_of_correct"
    }
    
}
