//
//  QuizCoreDataSourceProtocol.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.5.2021..
//

import Foundation

protocol QuizCoreDataSourceProtocol {

    func fetchQuizzesFromCoreData(filter: FilterSettings) -> [Quiz]
    func saveNewQuizzes(_ Quizzes: [Quiz])

}

