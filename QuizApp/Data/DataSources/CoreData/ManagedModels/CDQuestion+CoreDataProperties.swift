//
//  CDQuestion1+CoreDataProperties.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 01.06.2021..
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var question: String
    @NSManaged public var answers: [String]?
    @NSManaged public var correctAnswer: Int32
    @NSManaged public var quiz: CDQuiz

}
