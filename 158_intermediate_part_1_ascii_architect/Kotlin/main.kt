//             .
//            ..
//           ...
//          ****
//         *****
//        ******
//       -------
//      --------
//     +++++++++
//    ++++++++++
//    abcdefghij
//

// j3f3e3e3d3d3c3cee3c3c3d3d3e3e3f3fjij3f3f3e3e3d3d3c3cee3c3c3d3d3e3e3fj


fun String.repeat(times: Int): String {
    var result = StringBuffer()
    for (i in 0 until times) {
        result.append(this)
    }
    return result.toString()
}


fun drawBuilding(input: String) {

    // generate templates
    val templateRoot = "...***--++"
    var templates = HashMap<Char, String>()

    for ((idx, c) in ('a'..'j').withIndex()) {
        println("c ${c} index ${idx}")
        templates.put(c, templateRoot.substring(templateRoot.length - 1 - idx until templateRoot.length))

    }
    println("chars ${templates}")

    // generate printout
    var digit: Int = 0
    var lines = ArrayList<String>()

    var result = ""
    var maxLen = 0

    for (c in input) {
        var line = ""
        if (Character.isDigit(c)) {
            digit = Integer.parseInt(c.toString())
        } else {
            line = templates[c]!!
            if (digit != 0) {
                line += " ".repeat(digit)
                digit = 0
            }

        }
        lines.add(line)
        if (line.length > maxLen) {
            maxLen = line.length
        }
    }

    val paddedLines = lines.map { it.padStart(maxLen, ' ') }


    for (i in 0 until maxLen) {
        for (line in paddedLines) {
            print(line[i])
        }
        println()
    }

}

fun main(args: Array<String>) {
    val res = drawBuilding("j3f3e3e3d3d3c3cee3c3c3d3d3e3e3f3fjij3f3f3e3e3d3d3c3cee3c3c3d3d3e3e3fj")
    println(res)
}

