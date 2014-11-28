
extension String {
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            let endIndex = advance(startIndex, r.endIndex - r.startIndex)
            return self[Range(start: startIndex, end: endIndex)]
        }
    }

}



let brailleDef: [Character:String] =
    ["a": "o.....",
      "b": "o.o...",
      "c": "oo....",
      "d": "oo.o..",
      "e": "o..o..",
      "f": "ooo...",
      "g": "oooo..",
      "h": "o.oo..",
      "i": ".oo...",
      "j": ".ooo..",
      "k": "o...o.",
      "l": "o.o.o.",
      "m": "oo..o.",
      "n": "oo.oo.",
      "o": "o..oo.",
      "p": "ooo.o.",
      "r": "o.ooo.",
      "s": ".oo.o.",
      "t": ".oooo.",
      "u": "o...oo",
      "v": "o.o.oo",
      "w": ".ooo.o",
      "x": "oo..oo",
      "y": "oo.ooo",
      "z": "o..ooo"  ]


let asciiDef: [String: Character] = {
    var result = [String: Character]()

    for (key, value) in brailleDef {
        result[value] = key
    }
    return result

}()


func asciiToBraille(input: String) -> String {

    let input = input.lowercaseString

    var result: String = ""

    for rng in ([0...1, 2...3, 4...5]) {
        for c in input {
            if let text: String = brailleDef[c] {
                result += text[rng]
                result += " "
            }

        }
    result += "\n"

    }

    return result
}



func brailleToAscii(input: String) -> String {

    let lines = split(input, { $0 == "\n" })
    var result = ""

    var i = 0
    let length = countElements(lines[0])
    while i + 1 < length {
        let ascii = lines[0][i...i+1] + lines[1][i...i+1] + lines[2][i...i+1]
        if let c = asciiDef[ascii] {
            result.append(c)
        } else {
            result.append("?" as Character)
        }
        i += 3

    }
    return result
}



// print(brailleDef)


println(asciiToBraille("Hello world"))



let text = "o. o. o. o. o. .o o. o. o. oo\n" +
           "oo .o o. o. .o oo .o oo o. .o\n" +
           ".. .. o. o. o. .o o. o. o. ..\n"


println(brailleToAscii(text))



