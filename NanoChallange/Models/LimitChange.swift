//
//  LimitChange.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 05/05/21.
//

import Foundation

struct LimitChange {
    var date: Date
    var amount: Int
    
    func getStringDateFull() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    func getMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        
        return formatter.string(from: date)
    }
    
    func getDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}
