//
//  Result.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation
enum Result<Success, Failure> where Failure : Error{
    case success(Success)
    case failure(Failure)
}
