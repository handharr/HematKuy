//
//  Protocols.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 01/05/21.
//

import Foundation

protocol AddTransactionDelegate {
    func transactionDidSave(amount: String, name: String) 
}

protocol SetBudgetAmount {
    func setAmount()
}
