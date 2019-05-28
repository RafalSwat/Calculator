import Foundation


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
    
    
    struct BinaryStruct {
        var binaryFunction: (Double, Double) -> Double
        var firstArgument: Double
    }
    private var pending: BinaryStruct? // ? -> when unary then must be nil
    
    // in equal and binary (to can make "5*5*5" without "=" each time)
    func performBinaryOperation() {
        if pending != nil {
            //print(numberStorage, pending?.firstArgument)
            numberStorage = (pending!.binaryFunction(pending!.firstArgument, numberStorage))
            pending = nil // after "=" pending variable again free
        }
    }
    
    // Holds a string with a corresponding operation
    var operations: Dictionary <String, OperationType> = [
        "AC" : OperationType.Unary(reset),
        "+/-" : OperationType.Unary(changeASign),
        "%" : OperationType.Unary(percentage),
        "C" : OperationType.Unary(delete),
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
extension Operation  {

    static func addition(argument1: Double, argument2: Double) -> Double {
        return argument1 + argument2
    }
    static func subtraction(argument1: Double, argument2: Double) -> Double {
        return argument1 - argument2
    }
    static func multiplication(argument1: Double, argument2: Double) -> Double {
        return argument1 * argument2
    }
    static func division(argument1: Double, argument2: Double) -> Double {
        return argument1 / argument2
    }
    
    static func reset(argument : Double) -> Double {
        return 0.0
    }
    static func changeASign(argument: Double) -> Double {
        return argument * (-1)
    }
    static func percentage(argument: Double) -> Double {
        return argument / 100.0
    }
    static func delete(argument: Double) -> Double{
        
        var numberAsString = String(argument)
        
        if argument == 0 {
            return 0.0
        }
        else if argument.truncatingRemainder(dividingBy: 1) == 0 { // % operation on float
            numberAsString = String(numberAsString.dropLast(3)) // because last letter of double looks like "21... 321.0"
        }
        else {
            numberAsString = String(numberAsString.dropLast())
        }
        if let numberAsDouble: Double = Double(numberAsString) {
            return numberAsDouble
        }
        else {
            return 0.0
        }
    }

}
