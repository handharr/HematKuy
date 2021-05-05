//
//  SavingAmountCellViewModel.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 03/05/21.
//

import UIKit
import CoreData

class SavingAmountCellViewModel {
    var items: [Transactions]?
    var dailys: DailyExpense?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var type: String
    var sum: Int = 0
    var limitAmount: Int = {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "limitAmount")
    }()
    var days: Int? = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return Int(formatter.string(from: Date()))
    }()
    
    init(type: String) {
        self.type = type
        fetchData()
        sum = getSum()
    }
    
    private func fetchData() {
        do {
            // create request
            let request = Transactions.fetchRequest() as NSFetchRequest<Transactions>
            
            // set filtering
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/yyy"
            
            let pred = NSPredicate(format: "dateString CONTAINS %@", formatter.string(from: Date()))
            request.predicate = pred
            
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            // fetch item
            items = try context.fetch(request)
            
        } catch {
            print("error fetch")
        }
    }
    
    private func getSum() -> Int {
        guard let items = items else {return 0}
        
        var sum = 0
        
        for x in items {
            sum += Int(x.amount)
        }
        
        return sum
    }
    
    func getSaveAmount() -> Int {
        
        // unwrap days
        guard let days = days else {return 0}
        
        return (limitAmount * days) - sum
    }
    
    func getPercentage() -> Int {
        guard let days = days else {return 0}
        let divider = limitAmount * days
        
        return Int(Float(getSaveAmount()) / Float(divider) * 100)
    }
}
