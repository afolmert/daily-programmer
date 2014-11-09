
// http://www.reddit.com/r/dailyprogrammer/comments/2ao99p/7142014_challenge_171_easy_hex_to_8x8_bitmap/

let DEBUG = false

extension Character {
    func toAscii() -> Int {
        for c in String(self).utf8 {
            return Int(c)
        }
        return 0
    }

    func uppercaseCharacter() -> Character {
        return Array(String(self).uppercaseString)[0]
    }

    static func fromAscii(i: Int) -> Character {
        return Character(UnicodeScalar(i))

    }
}

func printAsciiTable() {
    for i in 1...255 {
        print("\(i): \(Character.fromAscii(i)) ")
            if i % 8 == 0 {
                println("")
            }
    }
}


func hexValue(c: Character) -> Int {
    let ascii = c.uppercaseCharacter().toAscii()
    if ascii >= 48 && ascii <= 57 {
        return ascii - 48
    } else if ascii >= 65 && ascii <= 70 {
        return ascii - 65 + 10

    }
    // let c
    // if c >= "A" && c <=
    return 0
}




func parseHexString(hex: String) -> Int {
    var chars = Array(hex)
    var result = 0

    for var i = chars.count - 1; i >= 0; i-- {
        result = result * 16 + hexValue(chars[i])
    }

    return result
}

println(parseHexString("AA"))

// func printAsciiTable() {
// for i in 1...255 {
// print(i)
// print(" ")
// println(String(Character(UnicodeScalar(i))))
// }
// }

// printAsciiTable()



// func dbg<T>(msg: T) {
// if DEBUG {
// println("DBG: \(msg)")
// }

// }



// func hexToBitmap(hexString: String) -> String {
// let comp = hexString.componentsSeparatedByString(" ")
// for c in comp {
// println(c)
// }
// return ""
// }



// var a = "1F"
// println(parseHexString(a))
// // println(ascii("1"))

// let c: Character = "1"
// println(c.ascii())

// for c in "ala ma koita".utf8 {
// println(c)
// }
//println("ala ma kta ".unicodeScalar)s
//println(parseHexString("1"))




