//
//  AddTransactionViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 01/05/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    @IBOutlet weak var addTransactionTableView: UITableView!
    
    var delegate: AddTransactionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTransactionTableView.delegate = self
        addTransactionTableView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        addTransactionTableView.register(AddTransactionTableViewCell.bindNib, forCellReuseIdentifier: AddTransactionTableViewCell.identifier)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let amountCell = addTransactionTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddTransactionTableViewCell
        let nameCell = addTransactionTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddTransactionTableViewCell
        
        guard let name = nameCell.inputField.text,
              let amount = amountCell.inputField.text else {return}
                    
        delegate?.transactionDidSave(amount: amount, name: name)
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddTransactionTableViewCell.identifier, for: indexPath) as! AddTransactionTableViewCell
        
        if indexPath.row == 0 {
            cell.inputLabel.text = "Amount"
            cell.inputField.placeholder = "0"
            cell.inputField.keyboardType = .asciiCapableNumberPad
        } else {
            cell.inputLabel.text = "Name"
            cell.inputField.placeholder = "What you buy?"
        }
        
        return cell
    }
    
    
}
