//
//  QuizLogic.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 31.05.2021..
//

import Foundation


class QuizLogic {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func sendResult(result: QuizResult) {
        let token = UserDefaults.standard.string(forKey: "token")
        networkService.sendResult(token: token!, quizResult: result)
                                
    }
}
