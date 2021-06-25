//
//  LoginLogic.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

import Foundation

class LoginLogic {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func login(username: String, password: String, callback: @escaping (LoginStatus) -> Void) {
        networkService.login(username: username, password: password) { loginStatus in
            callback(loginStatus)
        }
    }
    
}
