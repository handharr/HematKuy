//
//  ExpenseCollection.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 01/05/21.
//

import Foundation

class ExpenseCollection {
    static var Daily: [ String : DailyExpense] = [
        "01/05/2021" : DailyExpense(stringDate: "01/05/2021"),
        "30/04/2021" : DailyExpense(stringDate: "30/04/2021"),
        "29/04/2021" : DailyExpense(stringDate: "30/04/2021")
    ]
    static var limitAmount: Int = 50000
    
    static func getDaily(date: Date) -> DailyExpense? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateWanted = Daily[formatter.string(from: date)]
        
        return dateWanted ?? nil
    }
    
    static func addDaily(daily: DailyExpense) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateString = formatter.string(from: daily.date)
        
        Daily[dateString] = daily
    }
}
