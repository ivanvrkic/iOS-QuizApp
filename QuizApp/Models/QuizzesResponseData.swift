//
//  QuizzesResponseData.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation

struct QuizzesResponseData: Codable {
    let quizzes: [Quiz]
    
    enum CodingKeys: String, CodingKey {
        case quizzes
    }
}
