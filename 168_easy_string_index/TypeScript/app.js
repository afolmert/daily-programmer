/// <reference path='typings/node/node.d.ts' />
var fs = require('fs');
function endsWith(str, suffix) {
    return str.indexOf(suffix, str.length - suffix.length) !== -1;
}
function fileSizeSync(filepath) {
    var stats = fs.statSync(filepath);
    return stats['size'];
}
var files = fs.readdirSync('.');
for (var i = 0; i < files.length; i++) {
    var filename = files[i];
    if (endsWith(filename, '.js')) {
        console.log("======= " + filename + " (" + fileSizeSync(filename) + " bytes)");
        var contents = fs.readFileSync(filename, 'utf8');
        console.log(contents);
    }
}
