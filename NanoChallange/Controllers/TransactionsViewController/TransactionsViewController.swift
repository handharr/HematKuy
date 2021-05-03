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
                amount: "\(model.amount)"
            )
            expenseCell.textLabel?.text = modelUsed.name
            expenseCell.detailTextLabel?.text = modelUsed.amount
            
            return expenseCell
            
        } else if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0:
                labelCell.textLabel?.text = "This Month"
                return labelCell
            default:
                amountCell.amountLabel.text = "IDR 20.000"
                amountCell.amountLabel.textColor = UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1)
                return amountCell
            }
            
        } else {
            
            switch indexPath.row {
            case 0:
                labelCell.textLabel?.text = "Total"
                return labelCell
            default:
                amountCell.amountLabel.text = "IDR 80.000"
                amountCell.amountLabel.textColor = UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1)
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
            label.text = "Savings"
            return label
        case 2:
            label.text = "Today Expense"
            return label
        default:
            return nil
        }
    }
    
}
