
// http://www.reddit.com/r/dailyprogrammer/comments/2ggy30/9152014_challenge180_easy_looknsay/

let DEBUG = false

func dbg<T>(msg: T) {
    if DEBUG {
        println("DBG: \(msg)")
    }

}


func lookAndSay(num: String) -> String {

    var result = ""

    let chars = Array(num)

    dbg(chars.count)
    var count = 1

    for (i, c) in enumerate(chars) {
        dbg("\(i) : \(c)")
            if i == chars.count - 1 || c != chars[i + 1] {
                result += "\(count)\(c)"
                    count = 1
            } else {
                count++
            }
    }
    return result

}


var res = "1"

for i in 1...10 {
    res = lookAndSay(res)
    println(res)

}

