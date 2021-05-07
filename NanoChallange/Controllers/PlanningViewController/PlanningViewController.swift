//
//  PlanningViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit

class PlanningViewController: UIViewController {
    
    @IBOutlet weak var planTableView: UITableView!
    
    // coreData context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Planning"
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        planTableView.delegate = self
        planTableView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        planTableView.register(BudgetTableViewCell.bindNib, forCellReuseIdentifier: BudgetTableViewCell.identifier)
        planTableView.register(PlanReminderTableViewCell.bindNib, forCellReuseIdentifier: PlanReminderTableViewCell.identifier)
    }

}

    // MARK: - TableView Config

extension PlanningViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BudgetTableViewCell.identifier, for: indexPath) as! BudgetTableViewCell
            cell.setCell(model: BudgetCellViewModel(title: "Budget Per Day", delegate: self))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanReminderTableViewCell.identifier, for: indexPath) as! PlanReminderTableViewCell
            cell.reminderLabel.text = "Reminder Time"
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

    // MARK: - Set Budget Amount config

extension PlanningViewController: SetBudgetAmount {
    func setAmount() {
        let ac = UIAlertController(title: "Set Budget Amount", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.keyboardType = .asciiCapableNumberPad
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            let amount = ac.textFields?[0].text
            
            guard let amount = amount else {return}
            
            let defaults = UserDefaults.standard
            defaults.setValue(amount, forKey: "limitAmount")
            
            // add core data limit change
            let newItem = LimitChange(context: self.context)
            newItem.date = Date()
            newItem.amount = 50000
            
            do {
                try self.context.save()
            } catch {
                print("error save")
            }
        }))
        self.present(ac, animated: true, completion: nil)
    }
}
