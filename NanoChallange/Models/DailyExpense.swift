//
//  DailyExpense.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 30/04/21.
//

import Foundation

class DailyExpense {
    var date: Date?
    var limitAmount: Int?
    var expenses: [Transactions] = []
    
    init(date: Date, limit: Int) {
        self.date = date
        self.limitAmount = limit
    }
    
    init() {
        
    }
    
    func getTotalExpense() -> Int {
        var sum = 0
        
        for x in expenses {
            sum += Int(x.amount)
        }
        
        return sum
    }
    
}
