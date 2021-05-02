//
//  Expense.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 30/04/21.
//

import Foundation

class Expense {
    let name: String
    let amount: Int
    
    init(name: String, amount: Int) {
        self.name = name
        self.amount = amount
    }
    
    func getAmount() -> String {
        return "\(amount)"
    }
}

