//
//  LoginResponseData.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation

struct LoginResponseData: Codable {
    let token: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case token
        case userId = "user_id"
    }
}
