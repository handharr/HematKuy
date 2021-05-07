//
//  ExpenseCellViewModel.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import Foundation

struct ExpenseCellViewModel {
    let name: String
    let amount: String
    
    init(name: String, amount: Int) {
        self.name = name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        self.amount = "IDR \(formatter.string(from: NSNumber(value: amount)) ?? "0")"
    }
}
