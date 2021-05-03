//
//  BudgetCellViewModel.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 03/05/21.
//

import UIKit

struct BudgetCellViewModel {
    var title: String
    var delegate: SetBudgetAmount
    
    func getAmount() -> String {
        let defaults = UserDefaults.standard
        let amount = defaults.integer(forKey: "limitAmount")
        
        return "\(amount)"
    }
}
