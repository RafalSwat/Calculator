//
//  ViewController.swift
//  Calculator
//
//  Created by Rafał Swat on 28/05/2019.
//  Copyright © 2019 Rafał Swat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private var operation: Operation = Operation()
    // In case of "0" at begining of typing
    private var beginningOfEnteringTheNumber: Bool = true
    
    @IBOutlet private weak var calculatorScreen: UILabel!
    
    private var numberAsDouble: Double {
        get {
            return Double(calculatorScreen.text!)! //
        }
        set {
            calculatorScreen.text = String(newValue)
        }
    }
    
    @IBAction private func numberPressed(_ sender: UIButton) {
        
        let numberButton = sender.currentTitle!
        let displayOnScreen = calculatorScreen.text!
        
        if beginningOfEnteringTheNumber == true {
            calculatorScreen.text = numberButton
        }
        else {
            calculatorScreen.text = displayOnScreen + numberButton
        }
        beginningOfEnteringTheNumber = false
    }
    @IBAction func operationPressed(_ sender: UIButton) {
        if beginningOfEnteringTheNumber == false {
            // copy the display number as double to operation in Operation class
            operation.setNumber(number: numberAsDouble)
        }
        if let symbolOfOperation = sender.currentTitle {
            operation.doMath(symbol: symbolOfOperation)
            beginningOfEnteringTheNumber = true
        }
        numberAsDouble = operation.outCome
    }
    
    

}

