
// http://www.reddit.com/r/dailyprogrammer/comments/299hvt/6272014_challenge_168_easy_string_index/

class Regex {
    let _regex: NSRegularExpression

    let _pattern: String

    var regex: NSRegularExpression {
        return _regex
    }

    init(_ pattern: String) {
        _pattern = pattern
        var error: NSError?
        _regex = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)
        if let error = error {
            NSException(name: "Error in regex: " + pattern, reason: "Invalid regex", userInfo: nil).raise()
        }
    }

    func test(input: String) -> Bool {
        let matches = regex.matchesInString(input, options: nil, range: NSMakeRange(0, countElements(input)))
        return matches.count > 0
    }


}

extension String {
    func componentsSeparatedByRegex(regex: NSRegularExpression) -> [String] {
        let separator = ":::"
        let tmp = regex.stringByReplacingMatchesInString(
                self,
                options: NSMatchingOptions(),
                range: NSMakeRange(0, countElements(self)),
                withTemplate: separator)
        return tmp.componentsSeparatedByString(separator)
    }

}

infix operator =~ {}

func =~ (input: String, pattern: String) -> Bool {
    return Regex(pattern).test(input)

}



func testOperator() {
    if "hello" =~ "h" {
        println("YEa!")
    }

    if "ala" =~ "What " {
        println("Yea 1 21 ")
    }

    let r = Regex("hello")
    println(r.test("hello"))

    println(r.test("helloA"))
    println("We're good")

}


func testSplitByRegex() {

    let input = "...You...!!!@!3124131212 Hello have this is a --- string" +
        "Solved !!...? to test @\n\n\n#!#@#@%$**#$@ Congratz this!!!!!!!!!!!!!!!!one ---Problem\n\n"
    println(input)


    let reg = Regex("[^a-zA-Z0-9]+")
    println("ababa ++12".componentsSeparatedByRegex(reg.regex))
    println(input.componentsSeparatedByRegex(reg.regex))
}


func nthWord(input: String, nth: Int) -> String {
    let reg = Regex("[^a-zA-Z0-9]+")
    let words = input.componentsSeparatedByRegex(reg.regex)
    if nth >= 0 && nth < words.count {
        return words[nth]
    } else {
        return ""
    }

}



let input = "...You...!!!@!3124131212 Hello have this is a --- string" +
"Solved !!...? to test @\n\n\n#!#@#@%$**#$@ Congratz this!!!!!!!!!!!!!!!!one ---Problem\n\n"

println(nthWord(input , 1))
println(nthWord(input , 2))
println(nthWord(input , 4))





