//
//  FilterSettings.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 30.5.2021..
//

struct FilterSettings {

    let searchText: String?

    init(searchText: String? = nil) {
        self.searchText = (searchText?.isEmpty ?? true) ? nil : searchText
    }

}
