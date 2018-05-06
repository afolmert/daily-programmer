#!/cygdrive/c/Users/folmead1/AppData/Roaming/npm/ts-node

/// <reference path="typings/node/node.d.ts" />

import * as process from 'process'


const stdin = process.openStdin();

stdin.addListener("data", d => {
  main(d.toString().trim());
});

function main(input: string): void {

  const lines = input.split(/\r?\n/);

  const wordCount = parseInt(lines[0].trim(), 10);


  let maxWordLen = 0;

  for (let i = 0; i < wordCount; i++) {
    if ((lines[i + 1]).length > maxWordLen) {
      maxWordLen = lines[i + 1].length;
    }
  }


  for (let letterIdx = 0; letterIdx < maxWordLen; letterIdx++) {
    let word = '';
    for (let wordIdx = 0; wordIdx < wordCount; wordIdx++) {
      if (letterIdx < lines[wordIdx + 1].length) {
        word += lines[wordIdx + 1][letterIdx];
      } else {
        word += ' ';
      }
    }
    console.log(word);
  }

}