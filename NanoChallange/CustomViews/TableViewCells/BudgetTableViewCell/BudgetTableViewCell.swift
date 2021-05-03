//
//  BudgetTableViewCell.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetButton: UIButton!
    
    static let identifier = "BudgetTableViewCell"
    static let bindNib = UINib(nibName: "BudgetTableViewCell", bundle: nil)
    
    var delegate: SetBudgetAmount?
    
    func setCell(model: BudgetCellViewModel) {
        budgetLabel.text = model.title
        budgetButton.setTitle("IDR \(model.getAmount())", for: .normal)
        delegate = model.delegate
    }
    
    @IBAction func handleBudgetButtonTap(_ sender: UIButton) {
        delegate?.setAmount()
    }
    
}
