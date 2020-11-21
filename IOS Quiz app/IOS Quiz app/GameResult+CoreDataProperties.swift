//
//  GameResult+CoreDataProperties.swift
//  IOS Quiz app
//
//  Created by Sha Nawaz Hathalia on 2020-11-21.
//
//

import Foundation
import CoreData


extension GameResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameResult> {
        return NSFetchRequest<GameResult>(entityName: "GameResult")
    }

    @NSManaged public var numberOfQuestions: Int32
    @NSManaged public var rightAnswers: Int32
    @NSManaged public var date: Date?

}

extension GameResult : Identifiable {

}
