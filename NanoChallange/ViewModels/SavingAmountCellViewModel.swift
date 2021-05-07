//
//  SavingAmountCellViewModel.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 03/05/21.
//

import UIKit
import CoreData

class SavingAmountCellViewModel {
    // atrributes
    var type: String
    
    // properties
    var dailys: [DailyExpense]? = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var sum: Int = 0
    var transactions: [Int:[Transactions]] = [:]
    var limits: [LimitChange]?
    
    // computed properties
    var limitAmount: Int = {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: "limitAmount")
    }()
    var days: Int? = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return Int(formatter.string(from: Date()))
    }()
    
    // init function
    init(type: String) {
        self.type = type
        fetchLimit()
        fetchData()
        sum = getSum()
    }
    
    private func fetchLimit() {
        do {
            // create request
            let request = LimitChange.fetchRequest() as NSFetchRequest<LimitChange>
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            limits = try context.fetch(request)
        } catch {
            print("failed fetch limit")
        }
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
            let datas = try context.fetch(request)
            
            for x in datas {
                let day = Int(x.getDay()!)!
                
                if transactions[day] == nil {
                    transactions[day] = []
                }
                
                transactions[day]?.append(x)
            }

            guard let days = days else {return}

            for x in 1...days {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/yyy"
                let monthYear = formatter.string(from: Date())
                formatter.dateFormat = "dd/MM/yyy"
                let xDate = formatter.date(from: "\(x)/\(monthYear)")
                
                let temp = DailyExpense()
                temp.limitAmount = checkLimit(date: xDate!)
                temp.date = xDate!

                if let getTransactions = transactions[x] {
                    temp.expenses = getTransactions
                }
                
                dailys?.append(temp)
            }
        } catch {
            print("error fetch")
        }
    }
    
    private func getSum() -> Int {
        guard let dailys = dailys else {return 0}
        
        var sum = 0
        
        for x in dailys {
            sum += x.getTotalExpense()
        }
        
        return sum
    }
    
    private func getExpectedAllocation() -> Int {
        guard let dailys = dailys else {return 0}
        
        var saveTotal = 0
        
        for x in dailys {
            saveTotal += x.limitAmount!
        }
        
        return saveTotal
    }
    private func checkLimit(date: Date) -> Int {
        guard let limits = limits else {return 0}
        var amount = 0
        
        for x in limits {
            if date > x.date! {
                amount = Int(x.amount)
                break
            }
        }
        
        return amount
    }
    
    /// get total user save, Allocation - Spending
    func getSaveAmount() -> Int {
        
        return getExpectedAllocation() - sum
    }
    
    /// get total saving from allocation
    func getPercentage() -> Int {
        return Int(Float(getSaveAmount()) / Float(getExpectedAllocation()) * 100)
    }
    

}
