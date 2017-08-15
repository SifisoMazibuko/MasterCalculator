//
//  CalculatorBrain.swift
//  MasterCalculator
//
//  Created by Sifiso Mazibuko on 2017/08/11.
//  Copyright © 2017 Sifiso Mazibuko. All rights reserved.
//

import Foundation

func percentageOperation(_ firstOperand: Double) -> Double {
    return (firstOperand / 100)
}

func factorialOperation(_ firstOperand: Double) -> Double {
    return firstOperand == 1 ? 1 : firstOperand * factorialOperation(firstOperand - 1)
}

func reciprocalOperation(_ firstOperand: Double) -> Double {
    return (1.0 / firstOperand)
}

func logarithmOperation(_ Operand:  Double) -> Double {
    return log10(Operand)
}

func piOperation(_ Operand: Double) -> Double {
    return (Double.pi * Operand)
}

func squareOperation(_ Operand: Double) -> Double {
    return pow(Operand, 2)
}

struct CalculatorBrain {
    enum Operations {
        case EmptyOperation(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    private var accumulator: Double?
    var resultIsPending = false
    private var description: String!
    private let ellipses: String = "..."
    var symbolBetween: String = ""
    var op1: String = ""
    
    
    
    private var engine:  Dictionary<String, Operations> =
    [
        "π" : Operations.UnaryOperation(piOperation),
        "e" : Operations.EmptyOperation(M_E),
        "sin" : Operations.UnaryOperation(sin),
        "cos" : Operations.UnaryOperation(cos),
        "tan" : Operations.UnaryOperation(tan),
        "%" : Operations.UnaryOperation(percentageOperation),
        "x!" : Operations.UnaryOperation(factorialOperation),
        "x²" : Operations.UnaryOperation(squareOperation),
        "x⁻¹" : Operations.UnaryOperation(reciprocalOperation),
        "㏒" : Operations.UnaryOperation(logarithmOperation),
        "√" :  Operations.UnaryOperation(sqrt),
        "+" :  Operations.BinaryOperation(+),
        "−" :  Operations.BinaryOperation(-),
        "×" :  Operations.BinaryOperation(*),
        "÷" :  Operations.BinaryOperation({$0/$1}),
        "±" :  Operations.UnaryOperation({-$0}),
        "=" : Operations.Equals
        
    ]
    mutating func performOperation(_ mathSymbol: String){
        if let operation = engine[mathSymbol]{
            switch operation {
            case .EmptyOperation(let value):
                accumulator = value
            case .UnaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .BinaryOperation(let value):
                if accumulator != nil {
                    binaryOperation = BinaryOperation(function: value, firstOperand: accumulator!, secondOperand: accumulator!)
                    op1 = String(accumulator!)
                    resultIsPending = true
                    symbolBetween = mathSymbol
                }
            case .Equals:
                performBinaryOperation()
            }
        }
    }
    
    mutating func setOperand(_ operand:  Double){
        accumulator = operand
    }
    
    mutating func performBinaryOperation(){
        if accumulator != nil {
            accumulator = binaryOperation.perform(accumulator!)
            resultIsPending = false
        }
    }
    private var binaryOperation:  BinaryOperation!
    
    struct BinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand, secondOperand: Double
        func perform(_ secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func sequenceDescription(mathSymbol: String) -> String {
        if accumulator != nil{
            description = String(accumulator!) + mathSymbol + ellipses
        }
        resultIsPending = true
        return description
    }
    
    /*mutating func fullDescription(_ Op1: Double, mathSymbol: String, Op2: Double, symbol: String) -> String {
        //if accumulator != nil{
            description =  String(Op1) + mathSymbol + String(Op2) + symbol
        //}
        return description
    }*/
    
    mutating func fullDescription(_ Op1: String, mathSymbol: String, Op2: Double,symbol: String) -> String {
        if accumulator != nil{
        description =  String(Op1) + mathSymbol + String(Op2
            ) + symbol
        }
        return description
    }
    
    
    var result: Double! {
        get{
            return accumulator
        }
    }
}
