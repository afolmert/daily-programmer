
/**
 * Parses string in hexadecimal format
 */
fun parseHex(hex: String): Long {
    var result = 0L
    var weight = 1
    for (c in hex.reversed()) {
        val v = when (c) {
            in '0'..'9' -> c.toInt() - '0'.toInt()
            in 'A'..'F' -> c.toInt() - 'A'.toInt() + 10
            else -> 0
        }
        result += v * weight
        weight *= 16
    }
    return result
}

/**
 * Convert number to binary format
 */
fun toBinary(input: Long): String {
    var result = ""
    var num = input
    while (num > 0) {
        result += if (num % 2 == 0L) "0" else "1"
        num /= 2
    }
    return result.reversed()
}

/**
 *
 */
fun drawHexLine(hexLine: String) {
    hexLine.split(" ").forEach { hex ->

        val line = toBinary(parseHex(hex))
                .replace('0', ' ')
                .replace('1', 'X')
                .padStart(8, ' ')
        println(line)
    }
    println()
}


/**
 *
 */
fun main(args: Array<String>) {
    drawHexLine("18 3C 7E 7E 18 18 18 18")
    drawHexLine("FF 81 BD A5 A5 BD 81 FF")
    drawHexLine("AA 55 AA 55 AA 55 AA 55")
    drawHexLine("3E 7F FC F8 F8 FC 7F 3E")
    drawHexLine("93 93 93 F3 F3 93 93 93")
}

