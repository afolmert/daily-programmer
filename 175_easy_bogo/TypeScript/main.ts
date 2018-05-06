#!/cygdrive/c/Users/folmead1/AppData/Roaming/npm/ts-node

function isNil(obj: any): boolean {
  return obj === null || obj === undefined;
}

function shuffleArray(array: Array<any>, operations: number = 10) {

  const length = array.length;
  for (let i = 0; i < operations; i++) {
    let indexA = Math.floor(Math.random() * length);
    let indexB = Math.floor(Math.random() * length);
    const el = array[indexA];
    array[indexA] = array[indexB];
    array[indexB] = el;
  }
}

function areTheSame(array1: Array<any>, array2: Array<any>) {
  console.log(`Comparing ${array1} and ${array2}`);
  if (isNil(array1) || isNil(array2)) {
    return false;
  }
  if (array1.length != array2.length) {
    return false;
  }
  for (let i = 0; i < array1.length; i++) {
    if (!(array1[i] === array2[i])) {
      return false;
    }
  }
  return true;
}

function easyBogo(word1: string, word2: string): void {
  const array1 = word1.split('');
  const array2 = word2.split('');

  let iterations = 0;
  while (true) {
    iterations++;
    shuffleArray(array1);
    if (areTheSame(array1, array2)) {
      break;
    }

  }
  console.log(`Required ${iterations} iterations.`)
}

easyBogo('lolHe', 'Hello');