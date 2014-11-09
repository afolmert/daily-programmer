
// www.reddit.com/r/dailyprogrammer/comments/2d8yk5/8112014_challenge_175_easy_bogo/

func shuffle<T>(var s: [T]) -> [T] {

    var res: [T] = []

    while s.count > 0 {
        let idx = Int(arc4random_uniform(UInt32(s.count)))
            res.append(s[idx])
            s.removeAtIndex(idx)
    }
    return res
}

func shuffle(s: String) -> String {
    return String(seq: shuffle(Array(s)))
}


func unscramble(string s1: String, toString s2: String, #maxIterations: Int) -> (Bool, Int) {

    var result = false
    var iterations = 0
    while iterations < maxIterations {
        let s1Shuffled = shuffle(s1)
            if s1Shuffled == s2 {
                result = true
                    break
            }
        iterations++
    }

    return (result, iterations)

}


let (res, it) = unscramble(string: "lolHe", toString: "Hello", maxIterations: 1000)
println("Res : \(res) , it : \(it)")



