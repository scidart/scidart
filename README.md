# Scidart
Scidart is a experimental cross-platform scientific library for Dart.

## Goals
Your main goal is run where Dart can run, in other words, run on Flutter, Dart CLI, Dart web, etc.

## Motivation
Some time ago I tried make a guitar tuner with Flutter and I faced with the problem: Dart dind't have scientific library with main scientific algorithms. 
So, I tried implement something to help me with that problem.

## Instalation

## Examples

## Documentation

## Inspiration
Below, the list with all the main references of Scidart:

* SciPy: https://www.scipy.org/
* Jupyter: https://jupyter.org/
* JAMA A Java Matrix Package: https://math.nist.gov/javanumerics/jama/
* Commons Math The Apache Commons Mathematics Library: https://commons.apache.org/proper/commons-math/
* Roseta code: https://rosettacode.org/

## How to contribute
I recommend see the Todo List and choose a function to implement or choose a problem and implement the parts that are missing in Scidart.

The references for tests is obtained with SciPy.

All the contribution need have tests, documentation and examples, otherwise, the pull request will be rejected.

## Todo list
* complex numbers algebra (ok)
* polyfit (ok but need more tests)
* documentation with examples(ok)
* function to time the execution of a process (ok)
* circular convolution (ok)
* convolution (ok)
* random (ok)
* write, read txt (ok, but work only in PC)
* write, read csv (ok, but work only in PC)
* separate fast math (ok)
* test fast math (ok)
* refactor array(ok), array2d(ok), arrayComplex(ok), Complex(ok) class to be more functional
* write matrix operations tests (ok)
* implement determinant calculation (ok)
* integration and derivation (ok)
* filter FIR (ok)
* dbConverters (ok)
* write some examples: frequency stimator, step counter, FM modulation, AM modulation
* filter IIR
* generate a plot in memory (delegated to https://stackoverflow.com/questions/43703802/flutter-draw-graphs-on-the-screen)
* logSpace (https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.logspace.html)
* write a CLI to interact with the lib
* publish package
* show to the community
* write readme