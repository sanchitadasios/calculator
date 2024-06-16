//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    private var calculationLogic = CalculatorLogic()
    private var newNumberTyped : Bool = true
    
    private var isFinishedTypingNumber : Bool = true
    
    var displayValue : Double {
        get{
            guard let value = Double(displayLabel.text!) else{
                fatalError(("error in converting display Label to double \(displayLabel.text!)"))
            }
            return value
        }
        set{
            if calculationLogic.isInt(newValue){
                displayLabel.text = String(Int(newValue))
            }
            else{
                displayLabel.text = String(newValue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        if let calcMethod = sender.currentTitle {
            let operands = ["+","-","÷","×"]
            if operands.contains(calcMethod){
                newNumberTyped = false
            }
            calculationLogic.setNumber(displayValue, iSNewNumber: newNumberTyped)
            displayValue = calculationLogic.calculate(symbol: calcMethod)!
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
//            if let appendTo = Int(displayLabel.text!), appendTo != 0 {
//                displayLabel.text = displayLabel.text! + numValue
//            } else{
//                displayLabel.text = numValue
//            }
            newNumberTyped = true
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "."{
                    if !calculationLogic.isInt(displayValue){
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
        
        
    }
}

