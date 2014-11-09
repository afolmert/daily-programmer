// Run like this:
// xcrun swift -i ./main.swift -- 1 2 3


import Foundation

extension Int {
    
    
    func charToAscii(s: String) -> Int {
        for c in s.unicodeScalars {
            return Int(c.value)
        }

        return 0
    }
    


    func toStringWithBase(base: Int, length: Int = 8) -> String {
        
        var scalars: String[] = []
        
        var number = self
        while (number > 0) {

            let remainder: Int = number % base
            let ascii: Int = remainder < 10 ? charToAscii("0") + remainder : charToAscii("A") + remainder - 10
            scalars.append(String(UnicodeScalar(ascii)))
            number = number / base
            
        }
        

        while scalars.count < length {
            scalars.append("0")
        }
        
        return "".join(reverse(scalars))

    }
    
    func toDecString(length: Int = 8) -> String {
        return toStringWithBase(10, length: length)
    }
    
    func toHexString(length: Int = 8) -> String {
        return toStringWithBase(16, length: length)
    }
 

}



func readFileIntoData(fileName: String) -> UnsafeArray<UInt8>? {
    
    var error: NSError?
    
    let data = NSData.dataWithContentsOfFile(fileName, options: NSDataReadingOptions.DataReadingUncached, error: &error)
    
    if error != nil {
        println("ERROR OCCURRED!")
        println("\(error)")
        return nil
    } else {
        
        let ptr = UnsafePointer<UInt8>(data.bytes)
        let bytes = UnsafeArray<UInt8>(start: ptr, length: data.length)
        
        return bytes
        
        
    }
    
    
}



func dumpHex(filePath: String) {
    
    
    let fm = NSFileManager.defaultManager()
    if !fm.fileExistsAtPath(filePath) {
        println("Error: file \(filePath) not found!")
        return
    }
    
    
    
    let array = readFileIntoData(filePath)!
    var str = ""
    
    for var i = array.startIndex; i < array.endIndex; i++ {
        
        if i % 16 == 0 {
            if str != "" {
                print("  " + str)
            }
            
            println("")
            print(i.toHexString(length: 8) + " ")
            str = ""
        }
        print("\(Int(array[i]).toHexString(length: 2)) ")
        
        let sc = UnicodeScalar(Int(array[i]))
        if sc.value == 13 || sc.value == 10 {
            str += " "
        } else {
            str += sc.isPrint() ? String(sc) : "."
        }

        
        
    }
    
    // fill the remaining space
    var i = array.endIndex
    while i % 16 != 0 {
        print("   ")
        i++
    }
    print(" " + str)
    
    

}





func main() {
    let fm = NSFileManager.defaultManager()
    

    let arguments = Process.arguments[1..Process.arguments.count]
    println(arguments)
    
    
    for arg in arguments {
        println("ARG: \(arg):")
        
        if fm.fileExistsAtPath(arg) {
            dumpHex(arg)
        } else {
            println("\(arg) is not a file!")
        }
        
    }
    
}


main()
