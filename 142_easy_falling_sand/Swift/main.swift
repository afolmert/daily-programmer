let kSpace = "\u{00A0}"

extension String {
    func replace(what: String, with: String) -> String {
        return self.stringByReplacingOccurrencesOfString(what, withString: with, options: nil, range: nil)
    }

    func rpad(length: Int) -> String {

        var l = length - countElements(self)

        var result = ""

        while l > 0 {
            result += kSpace
            l--;
        }

        result += self
        return result



    }

}


func codeKata(input: String) -> String {

    for line in split(input, { $0 == "\n" }) {

        let line = line.replace(" ", with: "\u{00A0}")
        println(line)
    }

    return ""
}


enum Block: String {
    case Sand = "."
    case Stone = "#"
    case Empty = "\u{00A0}"

}

// let array2d: [[Block]] = Array(Array<Block>)

// func makeArray2d<T>(numCols: Int, numRows: Int, repeatedValue: T) -> [[T]] {

// }

protocol Drawable {
    var draw: String { get }
}

extension Int: Drawable {
    var draw: String { get { return "\(self)" } }
}


extension Block: Drawable {
    var draw: String { get { return "\(self.toRaw())" } }

}





class Matrix<T: Drawable> {
    var _grid: [T]

    let _default: T

    let _rowCount: UInt32

    let _colCount: UInt32

    private func error(message: String) {
        var e = NSException(name:"Error", reason:message, userInfo:nil)
        e.raise()

    }

    private func checkBoundsForRow(row: UInt32, column: UInt32) {
            if row >= _rowCount {
                error("invalid row \(row), maximum allowed is \(_rowCount - 1)")
            }
            if column >= _colCount {
                error("invalid column \(column), maximum allowed is \(_colCount - 1)")
            }
    }

    init(rowCount: UInt32, colCount: UInt32, repeatedValue: T) {

        _rowCount = rowCount
        _colCount = colCount
        _default = repeatedValue

        _grid = Array<T>(count: Int(colCount * rowCount), repeatedValue: repeatedValue)

    }


    subscript(row: UInt32, column: UInt32) -> T {

        get {
            checkBoundsForRow(row, column: column)
            return _grid[Int(_rowCount * column + row)]
        }

        set {
            checkBoundsForRow(row, column: column)
            _grid[Int(_rowCount * column + row)] = newValue

        }


    }

    var description: String {
        var result = ""

        let maxLen = _grid.reduce(0, {

            let l = countElements("\($1.draw)")
            return $0 > l ? $0 : l
        })

        println("MAXLEN \(maxLen)")

        for var i: UInt32 = 0; i < _rowCount; i++ {
            for var j: UInt32 = 0; j < _colCount; j++ {

                let cell = "\(self[i, j].draw) ".rpad(maxLen)
                result += cell
            }
            result += "\n"
        }

        return result
    }
}



let a: UInt32 = 4

let b: UInt32 = 2

let c: Int = Int(a * b)
println(c)

let matrix = Matrix<Int>(rowCount: 10, colCount: 10, repeatedValue: 1)

println(matrix[1, 1])

matrix[2, 3] = 14

matrix[3, 3] = 100

matrix[0, 8] = 3

println(matrix[1, 2])

println(matrix.description)

let m2 = Matrix<Block>(rowCount: 8, colCount: 8, repeatedValue: .Empty)

m2[1, 1] = .Stone
m2[2, 2] = .Sand

m2[2, 2] = .Sand
m2[2, 3] = .Sand

m2[4, 4] = .Stone

m2[4, 5] = .Stone
m2[4, 7] = .Stone

println(m2.description)

// let input = "5\n" +
// ".....\n" +
// "  #  \n" +
// "#    \n" +
// "     \n" +
// "     \n" +
// "    ."


// // codeKata(input)







