//
//  ViewController.swift
//  test
//
//  Created by Dmitry on 17/10/2018.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        set {
            var outputValue = "\(newValue)"
            var valueArray = outputValue.components(separatedBy: ".")
            if valueArray[1] == "0" {
                outputValue = valueArray[0]
            }
            displayResultLabel.text! = outputValue
            stillTyping = false
        }
    }
    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if stillTyping {
            if displayResultLabel.text!.count < 20 {
                displayResultLabel.text! = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsButtonPressed(_ sender: UIButton) {
        firstOperand = currentInput
        stillTyping = false
        operationSign = sender.currentTitle!
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "✕":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }

    @IBAction func resetButtonPressed(_ sender: UIButton) {
        stillTyping = false
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        operationSign = ""
    }

    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func percentButtonPressed(_ sender: UIButton) {
    }
    

}
