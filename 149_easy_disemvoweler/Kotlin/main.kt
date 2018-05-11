
fun Char.isVowel(): Boolean {
    val s = setOf('a', 'e', 'i', 'o', 'u')
    return s.contains(this)
}


fun disemvowel(word: String): Pair<String, String> {
    val left = word.filter { !it.isVowel() && !it.isWhitespace() }
    val right = word.filter { it.isVowel() }
    return Pair(left, right)
}

fun main(args: Array<String>) {
    println(disemvowel("two drums and a cymbal fall off a cliff"))


}
