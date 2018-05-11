
fun factor(n: Int): String {
    val factors = ArrayList<Int>()

    var num = n
    var aux = 2
    while (num > 1) {
        if (num % aux == 0) {
            factors.add(aux)
            num /= aux
        } else {
            aux++
        }
    }
    return factors.joinToString(" * ")
}

fun main(args: Array<String>) {
    println(factor(199))
    println(factor(200))

}
