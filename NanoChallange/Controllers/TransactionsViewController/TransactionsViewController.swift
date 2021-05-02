//
//  TransactionsViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit

class TransactionsViewController: UIViewController {
    

    @IBOutlet weak var transactionTableView: UITableView!
    
    var expenses: [ExpenseCellViewModel] = [
        .init(name: "Makan Bakso", amount: "10.000"),
        .init(name: "Jajan Indomaret", amount: "5.000"),
        .init(name: "Es Jus", amount: "15.000")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Transactions"
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        transactionTableView.register(SavingTableViewCell.bindNib, forCellReuseIdentifier: SavingTableViewCell.identifier)
        transactionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "labelCell")
    }

}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0, 1:
            return 2
        case 2:
            return expenses.count
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
            let model = expenses[indexPath.row]
            expenseCell.textLabel?.text = model.name
            expenseCell.detailTextLabel?.text = model.amount
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
