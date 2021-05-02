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

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBAction func handleBudgetButtonTap(_ sender: Any) {
    }
    
}
