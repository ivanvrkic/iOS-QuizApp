//
//  UseCase.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

import Foundation

final class QuizUseCase {

    private let quizRepository: QuizDataRepositoryProtocol


    init(quizRepository: QuizDataRepositoryProtocol) {
        self.quizRepository = quizRepository
    }

    func refreshData() throws {
        let token = UserDefaults.standard.string(forKey: "token")
        try quizRepository.fetchRemoteData(token: token!)
    }

    func getQuizzes(filter: FilterSettings) -> [Quiz] {
        quizRepository.fetchLocalData(filter: filter)
    }

}
