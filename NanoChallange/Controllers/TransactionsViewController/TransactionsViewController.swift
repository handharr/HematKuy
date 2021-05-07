//
//  TransactionsViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit
import CoreData

class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    // coreData context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var expenses: DailyExpense = DailyExpense()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Transactions"
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        registerCells()
        
        fetchData()
    }
    
    private func registerCells() {
        transactionTableView.register(SavingTableViewCell.bindNib, forCellReuseIdentifier: SavingTableViewCell.identifier)
        transactionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "labelCell")
    }
    
    private func fetchData() {
        do {
            // create request
            let request = Transactions.fetchRequest() as NSFetchRequest<Transactions>
            
            // set filtering
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyy"
            let pred = NSPredicate(format: "dateString == %@", formatter.string(from: Date()))
            request.predicate = pred
            
            // fetch item
            let items = try context.fetch(request)
            
            // save to model
            expenses.expenses = items
            
        } catch {
            print("error fetch")
        }
    }
    
    func fetchAndReload() {
        if transactionTableView != nil {
            fetchData()
            transactionTableView!.reloadData()
        }
    }
}

// MARK: - Table View Config

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0, 1:
            return 2
        case 2:
            return expenses.expenses.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let labelCell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
        let amountCell = tableView.dequeueReusableCell(withIdentifier: SavingTableViewCell.identifier, for: indexPath) as! SavingTableViewCell
        var expenseCell = tableView.dequeueReusableCell(withIdentifier: "expenseCell")
        if expenseCell == nil {
            expenseCell = UITableViewCell(style: .value1, reuseIdentifier: "expenseCell")
        }
        
        if indexPath.section == 2 {
            
            guard let expenseCell = expenseCell else {return UITableViewCell()}
            let model = expenses.expenses[indexPath.row]
            let modelUsed = ExpenseCellViewModel(
                name: model.name ?? "Unknown",
                amount: Int(model.amount)
            )
            expenseCell.textLabel?.text = modelUsed.name
            expenseCell.detailTextLabel?.text = modelUsed.amount
            
            return expenseCell
            
        } else if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                labelCell.textLabel?.text = "Saving Amount"
                return labelCell
            default:
                amountCell.setCell(model: SavingAmountCellViewModel(type: "amount"))
                return amountCell
            }
            
        } else {
            
            switch indexPath.row {
            case 0:
                labelCell.textLabel?.text = "Saving Percentage"
                return labelCell
            default:
                amountCell.setCell(model: SavingAmountCellViewModel(type: "percentage"))
                return amountCell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0,2:
            return 40
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.sectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .label
        
        switch section {
        case 0:
            label.text = "Savings This Month"
            return label
        case 2:
            label.text = "Today Expense"
            return label
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section != 2 {return nil}
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            // get item to remove
            let itemToRemove = self.expenses.expenses[indexPath.row]
        
            // remove items
            self.context.delete(itemToRemove)
            
            // save context
            do {
                try self.context.save()
            } catch {
                print("error delete after save")
            }
            
            // fetch and reload
            self.fetchAndReload()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
