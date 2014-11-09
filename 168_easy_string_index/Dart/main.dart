#!/usr/bin/env dart


final List<String> TEST_CASES = [
    r"""lazy fox jumps over a dog""",
    r"""easy does it hello world""",
    r"""...You...!!!@!3124131212 Hello have this is a --- string Solved !!...? to test @\n\n\n#!#@#@%$**#$@ Congratz
this!!!!!!!!!!!!!!!!one ---Problem\n\n"""

];


String getWord(List<String> words, int index) {
  if (index >= 0 && index < words.length) {
    return words[index];
  } else {
    return "";
  }
}

void solveTestCase(String input, [List<int> indexes = const [-10, -1, 0, 1, 2, 3, 7, 100, 1000]]) {
  print('solveTestCase START for input ' + input);
  print(input);

  List<String> words = input.split(new RegExp(r'[^a-zA-Z0-9]+'));

  for (var idx in indexes) {
    print('Word at index $idx: ${getWord(words, idx)}');
  }

}


void main() {

  int i = 0;
  for (String testCase in TEST_CASES) {
    print('==== Processing case $i');
    solveTestCase(testCase);
    i++;
  }
}
