//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

protocol NetworkServiceProtocol {
    
    func login(username: String, password: String, completionHandler: @escaping (LoginStatus) -> Void)

    func fetchQuizzes(token: String, completionHandler: @escaping ([Quiz]) -> Void)
    
    func sendResult(token: String, quizResult: QuizResult)
    
    //func fetchLeaderboardForQuiz(token: String, quizId: Int, completionHandler: @escaping ([LeaderboardResult]) -> Void)
    
}
