//
//  PlanReminderTableViewCell.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit

class PlanReminderTableViewCell: UITableViewCell {
    
    static let identifier = "PlanReminderTableViewCell"
    static let bindNib = UINib(nibName: "PlanReminderTableViewCell", bundle: nil)

    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
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
    
    @IBAction func handleTimeChange(_ sender: Any) {
    }
}
