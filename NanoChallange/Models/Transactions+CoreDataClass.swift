//
//  Transactions+CoreDataClass.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 02/05/21.
//
//

import Foundation
import CoreData

@objc(Transactions)
public class Transactions: NSManagedObject {
    func getStringDateFull() -> String? {
        guard let date = date else {return nil}
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    func getMonthYear() -> String? {
        guard let date = date else {return nil}
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    func getDay() -> String? {
        guard let date = date else {return nil}
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}
