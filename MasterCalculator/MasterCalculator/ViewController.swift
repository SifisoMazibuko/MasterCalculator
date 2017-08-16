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
        
           
                if calculator.resultIsPending == true {
                    finalResults.text = calculator.sequenceDescription(mathSymbol:mathSymbol)
                    
                }
                
                if calculator.resultIsPending == false {
                    finalResults.text = calculator.fullDescription(calculator.op1, mathSymbol: calculator.symbolBetween, Op2: displayValue, symbol: mathSymbol)
                }
            
            if mathSymbol == "㏒" && results.text != ""{
                finalResults.text = "log(" + results.text! + ")"
            }else if mathSymbol == "㏒"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "sin" && results.text != ""{
                finalResults.text = "sin(" + results.text! + ")"
            }else if mathSymbol == "sin"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "cos" && results.text != ""{
                finalResults.text = "cos(" + results.text! + ")"
            }else if mathSymbol == "cos"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "tan" && results.text != ""{
                finalResults.text = "tan(" + results.text! + ")"
            }else if mathSymbol == "tan"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "π" && results.text != ""{
                finalResults.text = "π" + results.text! + ""
            }else if mathSymbol == "π"{
                finalResults.text = String("π")
                results.text = String(Double.pi)
            }
            
            if mathSymbol == "%" && results.text != ""{
                finalResults.text = "" + results.text! + "%"
            }else if mathSymbol == "%"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "√" && results.text != ""{
                finalResults.text = "√" + results.text! + ""
            }else if mathSymbol == "√"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "x²" && results.text != ""{
                finalResults.text = "(" + results.text! + ")²"
            }else if mathSymbol == "x²"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "x⁻¹" && results.text != ""{
                finalResults.text = "" + results.text! + "⁻¹"
            }else if mathSymbol == "x⁻¹"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "x!" && results.text != ""{
                finalResults.text = "" + results.text! + "!"
            }else if mathSymbol == "x!"{
                finalResults.text = String("")
            }
            
            if mathSymbol == "e" && results.text != "" {
                finalResults.text = String("")
            }else if mathSymbol == "e"{
                finalResults.text = String("e")
                results.text = String(M_E)
            }
            
            if mathSymbol == "±" && results.text != ""{
                finalResults.text = results.text!
            }else if mathSymbol == "±"{
                finalResults.text = String("")
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

