//
//  QuizzesLogic.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

import Foundation

class QuizzesLogic {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchQuizzes(callback: @escaping ([Quiz]) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        networkService.fetchQuizzes(token: token!) { quizzes in
                callback(quizzes)
            }
    }
}
