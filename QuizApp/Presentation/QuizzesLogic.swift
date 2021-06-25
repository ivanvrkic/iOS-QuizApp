//
//  QuizzesLogic.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

import Foundation

class QuizzesLogic {
    
    private let networkService: NetworkServiceProtocol
    private var quizUseCase: QuizUseCase!
    private var quizzes: [Quiz] = []
    private var sectionNames: [String] = []
    
    init(networkService: NetworkService, quizUseCase: QuizUseCase) {
        self.networkService = networkService
        self.quizUseCase = quizUseCase
    }
    
    func fetchQuizzes(callback: @escaping ([Quiz]) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        networkService.fetchQuizzes(token: token!) { quizzes in
                callback(quizzes)
            }
    }
    
    func refreshQuizzes() throws {
        try quizUseCase?.refreshData()
    }

    func filterQuizzes(filter: FilterSettings) -> [Quiz]{
        quizUseCase.getQuizzes(filter: filter)
    }
}
