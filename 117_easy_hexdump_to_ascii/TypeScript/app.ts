/// <reference path='typings/node/node.d.ts' />

import fs = require('fs');


function numToStringWithBase(num: number, base: number): string {
    var scalars: string[] = [];
    while (num > 0) {
        var reminder: number = num % base;
        var ascii: number = reminder < 10 ?
            '0'.charCodeAt(0) + reminder :
            'A'.charCodeAt(0) + reminder - 10;
        scalars.push(String.fromCharCode(ascii));
        num = Math.floor(num / base);

    }
    return scalars.reverse().join('');
}

function numToDecString(num: number): string {
    return numToStringWithBase(num, 10);
}

function numToHexString(num: number): string {
    return numToStringWithBase(num, 16);
}

function numToOctalString(num: number): string {
    return numToStringWithBase(num, 8);
}


function rpad(str: string, width: number): string {
    while (str.length < width) {
        str = str + ' ';
    }
    return str;
}

function testFunctions() {
    console.log('Hello ');
    console.log('--- Testing Hex String ');

    for (var i = 0; i < 30; i++) {
        console.log(`${i} -> ${numToHexString(i) }`);
    }

    console.log('------ Testing Octal string ');

    for (var i = 0; i < 30; i++) {
        console.log(`${i} -> ${numToOctalString(i) }`);
    }

    console.log('------ Testing Dec string ');

    for (var i = 0; i < 30; i++) {
        console.log(`${i} -> ${numToDecString(i) }`);
    }

}

function dumpFileAsHex(filename: string, width: number, callback: (err: NodeJS.ErrnoException, data: string) => void) {

    fs.readFile(filename, (err: NodeJS.ErrnoException, buffer: Buffer) => {
        if (err) {
            callback(err, null);
        }

        var result: string = '';
        var hexCodes: string = '';
        var asciiCodes: string = '';

        for (var i = 0; i <= buffer.length; i++) {
            var hex: string = numToHexString(buffer[i]);
            var ascii: string = String.fromCharCode(buffer[i]);

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

    var filename: string = process.argv[2];
    if (!fs.existsSync(filename)) {
        console.log('Cannot find file ' + filename);
    }

    dumpFileAsHex(filename, 30, (err: NodeJS.ErrnoException, data: string) => {
        if (err) {
            throw err;
        }
        console.log(data);

    })
}

main();
