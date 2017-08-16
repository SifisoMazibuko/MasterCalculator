//
//  ViewController.swift
//  MasterCalculator
//
//  Created by Sifiso Mazibuko on 2017/08/11.
//  Copyright © 2017 Sifiso Mazibuko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var results: UILabel!
    @IBOutlet weak var finalResults: UILabel!
    private var userIsTyping =  false
    private var calculator = CalculatorBrain()
    var floatingPoint = String(",")
    var floatingPointClicked = true

    var displayValue: Double{
        get{
            userIsTyping = false
            return Double(results.text!)!
        }
        set{
            results.text = "\(newValue)"
        }
    }
    @IBAction func buttonClick(_ sender: UIButton) {
        let number = sender.currentTitle!
        if userIsTyping {
            let currentText = results.text!
            results.text = currentText + number
            
        }else{
            results.text = number
            userIsTyping = true
        }
        
        if number == floatingPoint {
            if floatingPointClicked {
                return
            }else{
                floatingPointClicked = true
            }
        }
        
        

    }
    
    @IBAction func clear(_ sender: UIButton) {
        results.text =  String("")
        finalResults.text = String("")
    }
    
    @IBAction func backSpace(_ sender: Any) {
        if userIsTyping {
            let text = results.text!
            results.text = text.substring(to: text.index(before: text.endIndex))
            if (results.text?.isEmpty)! {
                results.text = " "
                userIsTyping = false
            }
        }
    }
    //let symbolBetween: String = CalculatorBrain.performOperation(CalculatorBrain.)
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping{
            calculator.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathSymbol = sender.currentTitle{
            calculator.performOperation(mathSymbol)
            
            let digit = results.text!
            switch mathSymbol {
            case "㏒":
                finalResults.text = digit != "" ? "log(" + digit + ")" : digit
            case "sin":
                finalResults.text = digit != "" ? "sin(" + digit + ")" : digit
            case "cos":
                finalResults.text = digit != "" ? "cos(" + digit + ")" : digit
            case "tan":
                finalResults.text = digit != "" ? "tan(" + digit + ")" : digit
            case "π":
                finalResults.text = digit != "" ? "π " + digit + "" : digit
            case "%":
                finalResults.text = digit != "" ? "" + digit + "%" : digit
            case "x²":
                finalResults.text = digit != "" ? "(" + digit + ")²" : digit
            case "x⁻¹":
                finalResults.text = digit != "" ? "" + digit + "⁻¹" : digit
            case "√":
                finalResults.text = digit != "" ? "√" + digit + "" : digit
            case "x!":
                finalResults.text = digit != "" ? "" + digit + "!" : digit
            default:
                if calculator.resultIsPending == true {
                    finalResults.text = calculator.sequenceDescription(mathSymbol: mathSymbol)
                }else{
                    finalResults.text = calculator.fullDescription(calculator.op1, mathSymbol: calculator.symbolBetween, Op2: displayValue, symbol: mathSymbol)
                }
            }
        }
        
        
        if let result = calculator.result {
            displayValue = result
            userIsTyping = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

