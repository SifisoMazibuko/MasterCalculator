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
    //var symbol: String = CalculatorBrain.performOperation(ca)

    var displayValue: Double{
        get{
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
    }
    @IBAction func clear(_ sender: UIButton) {
        results.text = " "
        finalResults.text = " "
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
            
                /*if calculator.resultIsPending == true {
                    finalResults.text = calculator.sequenceDescription(mathSymbol:mathSymbol)

                }else{
                    //finalResults.text = calculator.fullDescription(displayValue, mathSymbol: calculator.symbolBetween, Op2: displayValue, symbol: mathSymbol)
                    finalResults.text = calculator.fullDescription(calculator.op1, mathSymbol: calculator.symbolBetween, Op2: displayValue, symbol: mathSymbol)
                    //let text = finalResults.text!
                    //finalResults.text = text + String(displayValue) + mathSymbol
                }*/
            
            if calculator.resultIsPending == true {
                let text = finalResults.text!
                finalResults.text = text + String(displayValue) + mathSymbol
            }
            
            if mathSymbol == "㏒" && results.text != ""{
                finalResults.text = "log(" + results.text! + ")"
            }
            
            if mathSymbol == "sin" && results.text != ""{
                finalResults.text = "sin(" + results.text! + ")"
            }
            
            if mathSymbol == "cos" && results.text != ""{
                finalResults.text = "cos(" + results.text! + ")"
            }
            
            if mathSymbol == "tan" && results.text != ""{
                finalResults.text = "tan(" + results.text! + ")"
            }
            
            if mathSymbol == "π" && results.text != ""{
                finalResults.text = "π" + results.text! + ""
            }
            
            if mathSymbol == "%" && results.text != ""{
                finalResults.text = "" + results.text! + "%"
            }
            
            if mathSymbol == "√" && results.text != ""{
                finalResults.text = "√" + results.text! + ""
            }
            
            if mathSymbol == "x²" && results.text != ""{
                finalResults.text = "(" + results.text! + ")²"
            }
            
            if mathSymbol == "x⁻¹" && results.text != ""{
                finalResults.text = "" + results.text! + "⁻¹"
            }
            
            if mathSymbol == "x!" && results.text != ""{
                finalResults.text = "" + results.text! + "!"
            }
            
            if mathSymbol == "±" && results.text != ""{
                finalResults.text = results.text!
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

