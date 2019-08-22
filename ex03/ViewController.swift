import UIKit

enum mathError: Error {
    case divisionByZero
}

class ViewController: UIViewController {

    var listValues :[Double] = []
    var listSigns :[Int] = []
    var value :Double = 0
    var isNumber :Bool = true
    var tag :Int = 0
    
    @IBOutlet weak var mainWindow: UILabel!
    
    @IBAction func pressButtonWithNum(_ sender: UIButton) {
        
        if (tag != 0 && tag != 10) {
            listValues.append(value)
            listSigns.append(tag)
            mainWindow.text = ""
            value = 0
            tag = 0
        }
        if (sender.tag == 10) { // =
            listValues.append(value)
            do {
                value = try calculate()
                printValueOnScreen()
            }
            catch mathError.divisionByZero {
                mainWindow.text = "Div by zero"
                listSigns.removeAll()
                value = 0
            }
            catch let error {
                print("Unspecified Error: \(error)")
            }
            listValues.removeAll()
            tag = 0
        }
        else {
            if (mainWindow.text == "Div by zero") {
                mainWindow.text = ""
            }
            value = Double(mainWindow.text! + String(sender.tag))!
            printValueOnScreen()
        }
    }
    
    func printValueOnScreen() {
        if (value - Double(Int(value)) == 0) {
            mainWindow.text = String(Int(value))
        }
        else {
            mainWindow.text = String(value)
        }
    }
    
    func calculate() throws ->Double {
        for (index, element) in listSigns.enumerated().reversed() {
            if (element == 13) {
                listValues[index] = listValues[index] * listValues[index + 1]
                listValues.remove(at: index + 1)
                listSigns.remove(at: index)
            }
            else if (element == 14) {
                if (listValues[index + 1] == 0) {
                    throw mathError.divisionByZero
                }
                else {
                    listValues[index] = listValues[index] / listValues[index + 1]
                    listValues.remove(at: index + 1)
                    listSigns.remove(at: index)
                }
            }
        }
        for (index, element) in listSigns.enumerated().reversed() {
            if (element == 11) {
                listValues[index] = listValues[index] + listValues[index + 1]
                listValues.remove(at: index + 1)
                listSigns.remove(at: index)
            }
            else if (element == 12) {
                listValues[index] = listValues[index] - listValues[index + 1]
                listValues.remove(at: index + 1)
                listSigns.remove(at: index)
            }
        }
        return listValues[0]
    }
    
    @IBAction func pressSignButton(_ sender: UIButton) {
        
        
        if (sender.tag == 15) { // AC
            mainWindow.text = ""
            value = 0
            listValues.removeAll()
            listSigns.removeAll()
            tag = 0
        }
        else if (sender.tag == 16) { // NEG
            value *= -1
            printValueOnScreen()
        }
        else {
            if (value != 0) {
                tag = sender.tag
            }
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
