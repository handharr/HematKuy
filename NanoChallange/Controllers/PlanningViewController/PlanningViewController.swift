//
//  PlanningViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit

class PlanningViewController: UIViewController {
    
    @IBOutlet weak var planTableView: UITableView!
    
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
            cell.budgetLabel.text = "Budget per day"
            cell.budgetButton.setTitle("IDR 50.000", for: .normal)
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
