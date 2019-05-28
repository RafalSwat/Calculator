//
//  Operation.swift
//  Calculator
//
//  Created by Rafał Swat on 28/05/2019.
//  Copyright © 2019 Rafał Swat. All rights reserved.
//

import Foundation

func addition(argument1: Double, argument2: Double) -> Double {
    return argument1 + argument2
}
func subtraction(argument1: Double, argument2: Double) -> Double {
    return argument1 - argument2
}
func multiplication(argument1: Double, argument2: Double) -> Double {
    return argument1 * argument2
}
func division(argument1: Double, argument2: Double) -> Double {
    return argument1 / argument2
}

func reset(argument : Double) -> Double {
    return 0.0
}
func changeASign(argument: Double) -> Double {
    return argument * (-1)
}
func percentage(argument: Double) -> Double {
    return argument / 100.0
}


class Operation {
    
    private var numberStorage: Double = 0.0
    
    func setNumber(number: Double) {
        numberStorage = number
    }
    
    // determines the type of operation
    enum OperationType {
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equal
    }
    
    
    // needed to apply binary operations in a switch as dictionary
    struct BinaryStruct {
        var binaryFunction: (Double, Double) -> Double
        var firstArgument: Double
    }
    private var pending: BinaryStruct? // ? -> when unary then must be nil
    
    // in equal and binary (to can make "5*5*5" without "=" each time)
    func performBinaryOperation() {
        if pending != nil {
            numberStorage = (pending!.binaryFunction(pending!.firstArgument, numberStorage)) // easy to use "!" cause if
            pending = nil // after "=" pending variable again free
        }
    }
    
    // Holds a string with a corresponding operation
    var operations: Dictionary <String, OperationType> = [
        "AC" : OperationType.Unary(reset),
        "+/-" : OperationType.Unary(changeASign),
        "%" : OperationType.Unary(percentage),
        "/" : OperationType.Binary(division),
        "x" : OperationType.Binary(multiplication),
        "-" : OperationType.Binary(subtraction),
        "+" : OperationType.Binary(addition),
        "=" : OperationType.Equal
    ]
    
    func doMath(symbol: String) {
        if let typeOfOperation = operations[symbol] {
            switch typeOfOperation {
                
            case OperationType.Unary(let function):
                numberStorage = function(numberStorage)
                
            case OperationType.Binary(let function):
                performBinaryOperation()
                pending = BinaryStruct(binaryFunction: function, firstArgument: numberStorage)
                
            case OperationType.Equal:
                performBinaryOperation()
            }
        }
    }
    
    var outCome: Double {
        get {
            return numberStorage
        }
    }
}
