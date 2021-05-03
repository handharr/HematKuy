//
//  DailyExpense.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 30/04/21.
//

import Foundation

class DailyExpense {
    var expenses: [Transactions] = []
    
    func getTotalExpense() -> Int {
        var sum = 0
        
        for x in expenses {
            sum += Int(x.amount)
        }
        
        return sum
    }
    
}
