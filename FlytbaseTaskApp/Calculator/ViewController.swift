//
//  ViewController.swift
//  FlytbaseTaskApp
//
//  Created by Suchiprava Sahoo on 23/08/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    ///UI Reference
    @IBOutlet weak var displayLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    
    ///Variable intialization
    var numberOnScreen : Double = 0
    var previousNumber : Double = 0
    var answer : Double = 0
    var performingMath = false
    var operation = 0
    var textAdded = String()
    var digitArry = [String]()
    
    //MARK: View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        appDelegate.historyArray = [String]()
    }
    
    ///Operator and digit  button with actions saparate with tags
    ///History button for H
    ///Clear calculator for C
    @IBAction func calculationBtn(_ sender: UIButton) {
        
        if sender.tag != 11 { ///C button for clear the all
            if sender.tag != 17 { ///H button for navigate  to history page
                if sender.tag != 16 { /// = button for show result
                    let sumText:String =  "\(sender.currentTitle!)" + "\(self.textAdded)"
                    self.textAdded = sumText
                    print(self.textAdded)
                    let reverseStr:String = reverse(self.textAdded)
                    print("Reverse \(reverseStr)")
                    self.displayLbl.text = reverseStr
                }
            }
        }
        if sender.tag == 11 {  ///C button for clear the all
            self.textAdded = ""
            self.displayLbl.text = ""
            self.totalLbl.text = ""
        }else if sender.tag == 16 { /// = button for show result
            setTotal()
            let historyStr = "\(displayLbl.text ?? "") = \(totalLbl.text ?? "")"
            appDelegate.historyArray?.append(historyStr)
        }else if sender.tag == 17{  ///H button for navigate  to history page
            let story = UIStoryboard.init(name:"Main" , bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    ///Get the total value
    func setTotal() {
        var firstIndex:Double
        digitArry = self.displayLbl.text!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        firstIndex = Double.init(digitArry.first ?? "") ?? 0
        self.digitArry.removeFirst()
        let operatorArr = self.displayLbl.text!.components(separatedBy:CharacterSet.init(charactersIn:"0,1,2,3,4,5,6,7,8,9"))
        let array = operatorArr.filter({ $0 != ""})
        
        let totl = calculateTotal(stringNumbers: digitArry, operators: array, initial: firstIndex)
        self.totalLbl.text = "\(totl)"
    }
    
    ///Reverse the text added
    func reverse(_ s: String) -> String {
        var str = ""
        //.characters gives the character view of the string passed. You can think of it as array of characters.
        for i in s {
            str = "\(i)" + str
            print ( str)
        }
        return str
    }
    
    ///Apply BADMSA
    func calculateTotal(stringNumbers: [String], operators: [String], initial: Double) -> Double {
        
        func performPendingOperation(operand: Double, operation: String, total: Double) -> Double {
            switch operation {
            case "+":
                return operand + total
            case "-":
                return operand - total
            default:
                return total
            }
        }
        var total = initial
        var pendingOperand = 0.0
        var pendingOperation = ""
        
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                switch operators[i] {
                case "+":
                    total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
                    pendingOperand = total
                    pendingOperation = "+"
                    total = number
                case "-":
                    total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
                    pendingOperand = total
                    pendingOperation = "-"
                    total = number
                case "÷":
                    total /= number
                case "×":
                    total *= number
                default:
                    break
                }
            }
        }
        
        // Perform final pending operation if needed
        total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
        
        // clear()
        return total
    }
}

