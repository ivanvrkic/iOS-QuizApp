//
//  CDQuiz1+CoreDataProperties.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 01.06.2021..
//

import Foundation
import CoreData

extension CDQuiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuiz> {
        return NSFetchRequest<CDQuiz>(entityName: "CDQuiz")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var title: String
    @NSManaged public var desc: String
    @NSManaged public var category: String
    @NSManaged public var level: Int32
    @NSManaged public var imageUrl: String
    @NSManaged public var questions: NSSet

}

// MARK: Generated accessors for questions
extension CDQuiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: CDQuestion)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: CDQuestion)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
