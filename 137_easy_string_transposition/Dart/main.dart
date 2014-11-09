#!/usr/bin/env dart

num max(Iterable<num> list) {
  if (list == null || list.length == 0) {
    return null;
  }
  return list.reduce((e, v) => e > v ? e : v);

}

String transpose(String input) {
  StringBuffer output = new StringBuffer();
  var words = input.split('\n').skip(1).toList();

  num maxLen = max(words.map((String e) => e.length));

  for (int i = 0; i < maxLen; i++) {
    for (int j = 0; j < words.length; j++) {
      if (words[j].length > i) {
        output.write(words[j][i]);
      } else {
        output.write(' ');
      }
    }
    output.write('\n');
  }
  return output.toString();
}

final List<String> TEST_CASES = [
    r"""1
Hello, World!""",
    r"""5
Kernel
Microcontroller
Register
Memory
Operator"""
];



void main() {

  int i = 0;
  for (String testCase in TEST_CASES) {
    print('Processing case $i');
    String result = transpose(testCase);
    print(result);
  }
}
