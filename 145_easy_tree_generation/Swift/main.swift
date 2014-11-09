import Foundation

extension String {

    func center(width: Int, char: Character) -> String {
        var result = ""
        for var i = 0; i < ((width - countElements(self)) / 2); i++ {
            result += char
        }
        result += self

        for var i = 0; i < width - countElements(result); i++ {
            result += char
        }
        return result
    }

    func multiplyBy(count: Int) -> String {
        var result = ""
        for var i = 0; i < count; i++ {
            result += self
        }
        return result
    }
}


func drawTree(input: String) -> String {

    println("Running code kata for input ")
    println(input)

    let components = input.componentsSeparatedByString(" ")

    if components.count != 3 {
        return ""
    }

    let len = components[0].toInt()
    let trunkChar = components[1]
    let bodyChar = components[2]


    // draw body
    for var i = 0; i < len; i += 2 {
        println(bodyChar.multiplyBy(i + 1).center(len!, char: " "))
    }

    // draw trunk
    println(trunkChar.multiplyBy(3).center(len!, char: " "))

    return "+"

}



drawTree("3 # *")
//
drawTree("13 = +")


drawTree("5 % ^")

drawTree("27 % ^")


