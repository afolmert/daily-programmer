/// <reference path='typings/node/node.d.ts' />
var fs = require('fs');
function numToStringWithBase(num, base) {
    var scalars = [];
    while (num > 0) {
        var reminder = num % base;
        var ascii = reminder < 10 ?
            '0'.charCodeAt(0) + reminder :
            'A'.charCodeAt(0) + reminder - 10;
        scalars.push(String.fromCharCode(ascii));
        num = Math.floor(num / base);
    }
    return scalars.reverse().join('');
}
function numToDecString(num) {
    return numToStringWithBase(num, 10);
}
function numToHexString(num) {
    return numToStringWithBase(num, 16);
}
function numToOctalString(num) {
    return numToStringWithBase(num, 8);
}
function rpad(str, width) {
    while (str.length < width) {
        str = str + ' ';
    }
    return str;
}
function testFunctions() {
    console.log('Hello ');
    console.log('--- Testing Hex String ');
    for (var i = 0; i < 30; i++) {
        console.log(i + " -> " + numToHexString(i));
    }
    console.log('------ Testing Octal string ');
    for (var i = 0; i < 30; i++) {
        console.log(i + " -> " + numToOctalString(i));
    }
    console.log('------ Testing Dec string ');
    for (var i = 0; i < 30; i++) {
        console.log(i + " -> " + numToDecString(i));
    }
}
function dumpFileAsHex(filename, width, callback) {
    fs.readFile(filename, function (err, buffer) {
        if (err) {
            callback(err, null);
        }
        var result = '';
        var hexCodes = '';
        var asciiCodes = '';
        for (var i = 0; i <= buffer.length; i++) {
            var hex = numToHexString(buffer[i]);
            var ascii = String.fromCharCode(buffer[i]);
            if (ascii == '\n' || ascii == '\r' || ascii == '\t' || ascii == '\b') {
                ascii = ' ';
            }
            if (hex.length == 1) {
                hex = '0' + hex;
            }
            asciiCodes += ascii;
            hexCodes += hex + ' ';
            if ((i + 1) % width == 0) {
                result += hexCodes + '   ' + asciiCodes + '\n';
                asciiCodes = '';
                hexCodes = '';
            }
        }
        if (hexCodes.length > 0) {
            result += rpad(hexCodes, width * 3) + '   ' + asciiCodes;
        }
        callback(null, result);
    });
}
function main() {
    if (process.argv.length < 3) {
        console.log('Please specify file argument');
        process.exit(1);
    }
    var filename = process.argv[2];
    if (!fs.existsSync(filename)) {
        console.log('Cannot find file ' + filename);
    }
    dumpFileAsHex(filename, 30, function (err, data) {
        if (err) {
            throw err;
        }
        console.log(data);
    });
}
main();
