//
//  ExpenseCollection.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 01/05/21.
//

import Foundation

class UserSetting {
    static var limitAmount: Int = 50000
    static func getLimitAmount() -> Int {
        
        let defaults = UserDefaults.standard
        let amount = defaults.integer(forKey: "limitAmount")
        
        return amount
    }
}
