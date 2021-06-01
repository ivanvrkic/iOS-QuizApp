//
//  QuizDataRepositoryProtocol.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.05.2021..
//

protocol QuizDataRepositoryProtocol {

    func fetchRemoteData(token: String) throws
    func fetchLocalData(filter: FilterSettings) -> [Quiz]

}
