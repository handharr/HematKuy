//
//  AddTransactionTableViewCell.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 01/05/21.
//

import UIKit

class AddTransactionTableViewCell: UITableViewCell {
    static let identifier = "AddTransactionTableViewCell"
    static let bindNib = UINib(nibName: "AddTransactionTableViewCell", bundle: nil)

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    
}
