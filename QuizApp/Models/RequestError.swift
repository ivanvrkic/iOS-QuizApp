//
//  RequestError.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.05.2021..
//

import Foundation
enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}
