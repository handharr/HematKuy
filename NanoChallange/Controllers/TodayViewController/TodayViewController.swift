//
//  TodayViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 29/04/21.
//

import UIKit
import CoreData

class TodayViewController: UIViewController {
    
    // coreData context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // UI Outlet
    @IBOutlet weak var dateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var amountInfoLabel: UILabel!
    let percentageLabel: UILabel = {
        let percentage = UILabel()
        percentage.text = "0%"
        percentage.textAlignment = .center
        percentage.font = UIFont.boldSystemFont(ofSize: 32)
        percentage.tintColor = .black
        return percentage
    }()
    
    // SegmentedControl State
    var dateArray: [Date] = []
    var currentDate = Date()
    var selectedDate: Date?
    var next2Day: Date?
    var nextDay: Date?
    
    // Expense State
    var todayExpenses: DailyExpense = DailyExpense()
    var expenseLimit: Int = 0
    
    // CircleProgress State
    var shapeLayer: CAShapeLayer!
    var trackLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup VC
        title = "Today"
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        // Setup Date
        next2Day = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)
        nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
        
        // setup segmented control
        setDateArray(date: currentDate)
        setSegmentedControl()
        
        // set dummy data
        expenseLimit = UserSetting.getLimitAmount()
        fetchTodayExpense()
        
        // Setup Circle
        setupCircle()
        
        // Setup View
        setupUI()
        
        // setProgress
        animateProgress()
    }
    
    // set todayExpense
    private func fetchTodayExpense() {
        
        // unwrap selected date
        guard let date = selectedDate else {return}
        
        do {
            // create request
            let request = Transactions.fetchRequest() as NSFetchRequest<Transactions>
            
            // set filtering
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyy"
            let pred = NSPredicate(format: "dateString == %@", formatter.string(from: date))
            request.predicate = pred
            
            // fetch item
            let items = try context.fetch(request)
            
            // save to model
            todayExpenses.expenses = items
            
        } catch {
            print("error fetch")
        }
    }
    
    // setup view
    private func setupUI() {
        
        view.addSubview(percentageLabel)
        
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    @IBAction func handleAddButton(_ sender: UIButton) {
    
        let vc = AddTransactionViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

    // MARK: - Transaction Config

extension TodayViewController: AddTransactionDelegate {
    
    func transactionDidSave(amount: String, name: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"

        // Add new transaction
        let newItem = Transactions(context: context)
        newItem.name = name
        newItem.amount = Int64(amount) ?? 0
        newItem.date = currentDate
        newItem.dateString = formatter.string(from: currentDate)

        // save context
        do {
            try context.save()
        } catch {
            print("error save")
        }

        // fetch data
        fetchTodayExpense()

        // reload view
        animateProgress()
    }
}

    // MARK: - Animation Config

extension TodayViewController {
    
    private func createShapeLayer(strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat = 20) -> CAShapeLayer
    {
        let circularPath = UIBezierPath(
            arcCenter: .zero,
            radius: 100,
            startAngle: 0,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.lineCap = .round
        layer.fillColor = fillColor.cgColor
        layer.position = view.center
        
        return layer
    }
    
    private func setupCircle() {
        
        // setup trackLayer
        trackLayer = createShapeLayer(
            strokeColor: UIColor(red: 55/255, green: 134/255, blue: 89/255, alpha: 0.20),
            fillColor: .secondarySystemBackground
        )
        view.layer.addSublayer(trackLayer)
        
        
        // setup shapeLayer
        shapeLayer = createShapeLayer(
            strokeColor: UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1),
            fillColor: UIColor.clear
        )
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
    }

    func animateProgress() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fillMode = .forwards
        basicAnimation.duration = 3
        basicAnimation.isRemovedOnCompletion = false
        
        let sum = todayExpenses.getTotalExpense()
        let percentage = CGFloat(sum)/CGFloat(expenseLimit)
        let leftAmount = expenseLimit - sum
    
        shapeLayer.strokeEnd = percentage
        shapeLayer.add(basicAnimation, forKey: "soBasic")
        percentageLabel.text = "\(Int(percentage * 100))%"
        
        if selectedDate == currentDate {
            amountInfoLabel.setTextInfoAmount(
                fullText: "You still have IDR \(leftAmount) left out of IDR \(expenseLimit)",
                word1: "\(leftAmount)",
                word2: "\(expenseLimit)",
                color1: UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1),
                color2: .black
            )
        } else if selectedDate == nextDay {
            amountInfoLabel.text = "Let's save again tomorrow!!"
        } else {
            amountInfoLabel.setTextInfoAmount(
                fullText: "Wow, on this day you save \(100 - Int(percentage * 100))%",
                word1: "\(100 - Int(percentage * 100))%",
                word2: nil,
                color1: .black,
                color2: nil)
        }
    }
}

    // MARK: - SegmentedControl Config

extension TodayViewController {
    
    private func setDateArray(date: Date) {
        // get yesterday and tomorrow date
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)
        let tommorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
        
        guard let yesterday = yesterday,
              let tomorrow = tommorrow
              else {return}
        
        // remove date array
        dateArray.removeAll()
        
        // append all 3 dates to array
        dateArray.append(yesterday)
        dateArray.append(date)
        dateArray.append(tomorrow)
        
        // change selected date
        selectedDate = date
    }
    
    private func setSegmentedControl() {
        // looping date array
        for x in 0..<dateArray.count {
            
            // get item from date array
            let date = dateArray[x]
            
            // set segment title
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d"
            let dateTitle = formatter.string(from: date)
            
            // check for selected index
            if date == selectedDate {
                dateSegmentedControl.selectedSegmentIndex = x
            }
            
            // check for set title
            if date == currentDate {
                dateSegmentedControl.setTitle("Today", forSegmentAt: x)
            } else if date == nextDay {
                dateSegmentedControl.setTitle("Tomorrow", forSegmentAt: x)
            } else {
                dateSegmentedControl.setTitle(dateTitle, forSegmentAt: x)
            }
            
            // check for disable segment
            if date == next2Day {
                dateSegmentedControl.setTitle(nil, forSegmentAt: x)
                dateSegmentedControl.setEnabled(false, forSegmentAt: x)
                continue
            }
            dateSegmentedControl.setEnabled(true, forSegmentAt: x)
        }
    }
    
    // Handle when segment change
    @IBAction func handleSegmentedChange(_ sender: UISegmentedControl) {
        // get selected index
        let selected = sender.selectedSegmentIndex
        
        // get date from array based on selected index
        let newDate = dateArray[selected]
        
        // setup segmentedControl and progress
        setDateArray(date: newDate)
        setSegmentedControl()
        fetchTodayExpense()
        animateProgress()
    }
}
