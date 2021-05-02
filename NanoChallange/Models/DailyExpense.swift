//
//  DailyExpense.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 30/04/21.
//

import Foundation

class DailyExpense {
    var date: Date
    var expenses: [Expense] = []
    
    init(stringDate: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        date = formatter.date(from: stringDate)!
    }
    
    init(date: Date) {
        self.date = date
    }
    
    func getTotalExpense() -> Int {
        var sum = 0
        
        for x in expenses {
            sum += x.amount
        }
        
        return sum
    }
    
    func addExpense(expense: Expense) {
        expenses.append(expense)
    }
    
}
