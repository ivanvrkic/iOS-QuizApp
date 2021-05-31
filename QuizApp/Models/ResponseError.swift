//
//  ResponseCodeError.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation
enum ResponseError: Error {
    case unAuthorized
    case forbidden
    case notFound
    case badRequest
    case clientError
    case serverError
}
