//
//  QuizDataRepository.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.5.2021..
//

import Foundation

class QuizDataRepository: QuizDataRepositoryProtocol {

    private let networkDataSource: NetworkServiceProtocol
    private let coreDataSource: QuizCoreDataSourceProtocol

    init(networkDataSource: NetworkServiceProtocol, coreDataSource: QuizCoreDataSourceProtocol) {
        self.networkDataSource = networkDataSource
        self.coreDataSource = coreDataSource
    }

    func fetchRemoteData(token: String) throws {
        networkDataSource.fetchQuizzes(token: token) { (quizzes) in
            self.coreDataSource.saveNewQuizzes(quizzes)
        }
        
    }

    func fetchLocalData(filter: FilterSettings) -> [Quiz] {
        coreDataSource.fetchQuizzesFromCoreData(filter: filter)
    }

}
