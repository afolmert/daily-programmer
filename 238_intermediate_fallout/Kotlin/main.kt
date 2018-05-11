import java.nio.file.Files
import java.nio.file.Paths
import java.util.*


/**
 *
 */
fun loadWords(inputPath: String): List<String> {
    val content = String(Files.readAllBytes(Paths.get(inputPath)))
    return content.split("\\r?\\n".toRegex()).filter { !it.isBlank() }
}

/**
 *
 */
fun findPositionMatches(word: String, userInput: String): Int {
    var matches = 0
    for (i in 0..word.length) {
        if (i < userInput.length &&
                word[i].toUpperCase() == userInput[i].toUpperCase()) {
            matches++
        }
    }
    return matches
}

/**
 *
 */
fun findPositionMatchesFunc(word: String, userInput: String): Int {
    return word
            .zip(userInput)
            .fold(0, { acc, (first, second) ->
                if (first.toUpperCase() == second.toUpperCase()) {
                    acc + 1
                } else {
                    acc
                }
            })
}

/**
 *
 */
fun main(args: Array<String>) {

    val inputPath = "C:\\Projects\\test-kotlin\\src\\main\\kotlin\\input.txt"
    val words = loadWords(inputPath)

    val word = words[Random().nextInt(words.size)]
    println("(Picking word $word}")

    println("I picked up a word with ${word.length} letters...")

    while (true) {
        val reader = Scanner(System.`in`)
        println("What is your guess?")
        val input = reader.next()
        if (input.isBlank()) {
            println("No input given")
        }
        val matches = findPositionMatchesFunc(word, input)
        if (matches == word.length) {
            println("GREAT! The word is $word")
        } else {
            println("Try again, correct position $matches/${word.length}")
        }

    }
}

