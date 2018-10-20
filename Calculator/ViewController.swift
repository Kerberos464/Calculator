import UIKit

class ViewController: UIViewController {
    var dotIsPressed = false
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
    
    
    func getCharacterByIndex(_ string: String, _ index: Int) -> String {
        let index = string.index(string.startIndex, offsetBy: index)
        return "\(string[index])"
    }
    
    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if stillTyping {
            if displayResultLabel.text!.count < 15 {
                displayResultLabel.text! = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            if getCharacterByIndex(displayResultLabel.text!, 0) != "0" {
                stillTyping = true
            }
        }
    }
    
    @IBAction func twoOperandsButtonPressed(_ sender: UIButton) {
        firstOperand = currentInput
        stillTyping = false
        operationSign = sender.currentTitle!
        dotIsPressed = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPressed = false
        
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
        dotIsPressed = false
    }

    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPressed {
            displayResultLabel.text = displayResultLabel.text! + "."
        } else if !stillTyping && !dotIsPressed {
            displayResultLabel.text = "0."
        }
        dotIsPressed = true
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }

}
