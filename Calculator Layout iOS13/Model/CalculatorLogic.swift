//
//  calculationLogin.swift
//  Calculator Layout iOS13
//
//  Created by Sanchita Das on 08/06/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation


struct CalculatorLogic {
    
    private var number : Double?
    private var iSNewNumber: Bool = false
    
    private var intermediateCalculation : (operand:String,firstNumber:Double)?

//    init(number:Double){
//        self.number = number
//    }
    
    mutating func setNumber(_ number : Double, iSNewNumber: Bool){
        self.number = number
        self.iSNewNumber = iSNewNumber
    }
    
    mutating func calculate(symbol calcMethod : String) -> Double? {
        
        if let n = number {
            switch calcMethod
            {
            case "+/-":
                return n * -1
            case "AC":
                intermediateCalculation = nil
                return 0
            case "%":
                return n * 0.01
            case "=":
                if iSNewNumber{
                    let result = performTwoNumCalculation(n2: n)
                    intermediateCalculation = nil
                    return result
                }
                else{
                    intermediateCalculation = nil
                    return n
                }
                
                //                        break
            default:
                if let ic = intermediateCalculation{
                    //                    intermediateCalculation?.secondNumber = n
                    //                    result = performTwoNumCalculation(n2: n)
                    
                    if let result = performTwoNumCalculation(n2: n){
                        intermediateCalculation?.firstNumber = result
                        intermediateCalculation?.operand = calcMethod
                        return result
                    } else{
                        return nil
                    }
                } else {
                    intermediateCalculation = (operand: calcMethod, firstNumber: n)
                    return n
                }
                
            }
        }
        return nil
    }
    
    func isInt(_ number: Double) -> Bool{
        return number == floor(number)
    }
    
    private func performTwoNumCalculation(n2 : Double) -> Double?{
        
        if let n1 = intermediateCalculation?.firstNumber,
           let operand = intermediateCalculation?.operand {
            switch(operand){
            case "+":
                return n1+n2
            case "-":
                return n1-n2
            case "÷":
                return n1/n2
            default:
                return n1*n2
            }
        }
        else {
            return n2
        }
//        return nil
    }
}
