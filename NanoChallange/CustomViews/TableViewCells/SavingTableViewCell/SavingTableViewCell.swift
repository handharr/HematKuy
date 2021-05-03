//
//  SavingTableViewCell.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit

class SavingTableViewCell: UITableViewCell {
    
    static let identifier = "SavingTableViewCell"
    static let bindNib = UINib(nibName: "SavingTableViewCell", bundle: nil)

    @IBOutlet weak var amountLabel: UILabel!
    
    func setCell(model: SavingAmountCellViewModel) {
        if model.type == "amount" {
            amountLabel.text = "IDR \(model.getSaveAmount())"
        } else {
            amountLabel.text = "\(model.getPercentage())%"
        }
        
        amountLabel.textColor = UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1)
    }
}
