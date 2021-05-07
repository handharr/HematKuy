//
//  LimitChange+CoreDataProperties.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 05/05/21.
//
//

import Foundation
import CoreData


extension LimitChange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LimitChange> {
        return NSFetchRequest<LimitChange>(entityName: "LimitChange")
    }

    @NSManaged public var date: Date?
    @NSManaged public var amount: Int64

}

extension LimitChange : Identifiable {

}
