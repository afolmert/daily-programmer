#!/usr/bin/env dart

import 'dart:math' as Math;

class Particle extends Object {
  double mass;
  double x;
  double y;

  Particle(this.mass, this.x, this.y);

  Particle.fromString(String input) {
    List<double> elements = input.split(' ').map((e) => double.parse(e)).toList();
    mass = elements[0];
    x = elements[1];
    y = elements[2];
  }

  String toString() {
    return 'Particle mass: $mass x: $x y: $y';
  }

  double distanceTo(Particle other) {
    double deltaX = this.x - other.x;
    double deltaY = this.y - other.y;
    return Math.sqrt(deltaX * deltaX + deltaY * deltaY);
  }


}


double calcRepulsionForce(Particle particle1, Particle particle2) {
  double dist = particle1.distanceTo(particle2);
  return (particle1.mass * particle2.mass) / (dist * dist);
}

double solveTestCase(String testCase) {
  List<Particle> particles = testCase.split('\n').map((e) => new Particle.fromString(e)).toList();
  return calcRepulsionForce(particles[0], particles[1]);
}




final List<String> TEST_CASES = [
    r"""1 -5.2 3.8
1 8.7 -4.1""",
    r"""4 0.04 -0.02
4 -0.02 -0.03"""

];


num rounded(num n) {
  return (n * 10000).round() / 10000;
}

void main() {

  int i = 0;
  for (String testCase in TEST_CASES) {
    print('Processing case $i');
    double result = solveTestCase(testCase);
    print(rounded(result));
    i++;
  }
}
