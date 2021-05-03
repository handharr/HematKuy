//
//  Transactions+CoreDataProperties.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 02/05/21.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Int64
    @NSManaged public var date: Date?
    @NSManaged public var dateString: String?

}

extension Transactions : Identifiable {

}
