// Run like this:
// xcrun swift -i ./main.swift


import Foundation

extension String {
    func chomp() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

extension Array {
    func randomElement() -> T {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }

}

let MAX_ELEMENT: UInt32 = 10

enum Operator : String {
    case
    Multiply = "*",
    Minus = "-",
    Plus = "+"
    
    static let allValues = [Multiply, Minus, Plus]
    
    static func randomOperator() -> Operator {
        return allValues.randomElement()
    }
}

func randomNumber() -> Int {
    return Int(arc4random_uniform(MAX_ELEMENT))
}


class Equation {
    var operators: Operator[] = []
    var elements: Int[] = []
    
    func regenerate(elemCount: Int) {
        operators.removeAll(keepCapacity: false)
        elements.removeAll(keepCapacity: false)
        
        for var i = 0; i < elemCount - 1; i++ {
            operators.append(Operator.randomOperator())
            
        }
        for var i = 0; i < elemCount; i++ {
            elements.append(randomNumber())
        }
    }
    
    

    func solve() -> Int {
        
        if elements.count == 0 {
            return 0
        }
        
        // perform all multiplies
        var multipliesSeen = false
        do {
           
            multipliesSeen = false
            for var i = 0; i < operators.count; i++ {
                if operators[i] == Operator.Multiply {
                    elements[i] = elements[i] * elements[i + 1]
                    elements.removeAtIndex(i + 1)
                    operators.removeAtIndex(i)
                    multipliesSeen = true
                    break;
                    
                }
                
            }
        } while (multipliesSeen)
        
        var result = elements[0]
        
        for var i = 0; i < operators.count; i++ {
            if operators[i] == Operator.Plus {
                result += elements[i + 1]
            } else if operators[i] == Operator.Minus {
                result -= elements[i + 1]
            } else {
                assert("Problem detected!")
            }
            
        }
        
        return result
        
    }
    
    
    
    func toString() -> String {
        var result = ""
        for var i = 0; i < elements.count; i++ {
            if i < elements.count - 1 {
                result += "\(elements[i])" + " " + operators[i].toRaw() + " "
            } else {
                result += "\(elements[i])"
            }

            
        }
        return result
    }
}





var fh = NSFileHandle.fileHandleWithStandardInput()

func loop() {
    println("Please solve equations")
    while true {
        print("> ")
        let equation = Equation()
        equation.regenerate(4)
        println(equation.toString())
        if let data = fh.availableData {
            var given = (NSString(data: data, encoding: NSUTF8StringEncoding) as String).chomp()
            let expected = "\(equation.solve())"
            if given == expected {
                println("Correct!")
            } else {
                println("Incorrect, expecting: \(expected)...")
            }

        }
    }

    
}



func testEquation() {
    var eq = Equation()
    println(eq.toString())
    
    eq.regenerate(3)
    println(eq.toString())
    println("RESULT: \(eq.solve())")
    
    eq.regenerate(4)
    println(eq.toString())
    println("RESULT: \(eq.solve())")
    
}


loop()