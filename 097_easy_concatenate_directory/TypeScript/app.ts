/// <reference path='typings/node/node.d.ts' />

import fs = require('fs');


function endsWith(str: string, suffix: string): boolean {
	return str.indexOf(suffix, str.length - suffix.length) !== -1;
}

function fileSizeSync(filepath: string): number {
	var stats: fs.Stats = fs.statSync(filepath);
	return stats['size'];
}

var files: string[] = fs.readdirSync('.');

for (var i = 0; i < files.length; i++) {
	var filename: string = files[i];
	if (endsWith(filename, '.js')) {
		console.log(`======= ${filename} (${fileSizeSync(filename)} bytes)` );
		var contents: string = fs.readFileSync(filename, 'utf8');
		console.log(contents);
		
	}
}

 