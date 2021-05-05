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
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let color = UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1)
        
        if model.type == "amount" {
            let value = model.getSaveAmount()
            let formattedValue = formatter.string(from: NSNumber(value: value))!
            
            amountLabel.text = "IDR  \(formattedValue)"
            amountLabel.textColor = color
        } else {
            amountLabel.text = "\(model.getPercentage())%"
        }
        amountLabel.textColor = color
    }
}
