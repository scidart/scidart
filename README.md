# SciDart

**SciDart** is a experimental cross-platform scientific library for Dart.

## Goals
The main goal of **SciDart** is run where Dart can run, in other words, run on Flutter, Dart CLI, Dart web, etc.

## Motivation
Some time ago I tried make a guitar tuner (frequency estimator) with Flutter and I faced with the problem: Dart dind't 
have a unified scientific library. 
So, I tried implement something to help me and the community with this problem.

## Instalation


## Dart REPL for prototyping quickly
Dart don't have [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) by default but I found [this amazing post from Andreas Kirsch
](https://medium.com/dartlang/dart-repl-poc-f327e3769b6f) and He implemented a experimental Dart REPL. 
But the [current library don't support Dart SDK > 2.0.0](https://github.com/BlackHC/dart_repl/issues/5). 
So, I decided to leave this work pending for now.

## SciDart structure
numdart
scidart
io

## Examples


## Inspiration
Below, the list with all the main references of **SciDart**:

* SciPy: https://www.scipy.org/
* Jupyter: https://jupyter.org/
* JAMA A Java Matrix Package: https://math.nist.gov/javanumerics/jama/
* Commons Math The Apache Commons Mathematics Library: https://commons.apache.org/proper/commons-math/
* Roseta code: https://rosettacode.org/

## How to contribute
I recommend see the Todo List and choose a function to implement or choose and solve a problem with **SciDart** and 
implement the missing parts.

The references values for any function need be obtained with SciPy.

Every contribution needs have tests, documentation and examples, otherwise, the pull request will be blocked.

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
* write a REPL to interact with the lib (Need support Dart SDK > 2 : https://medium.com/dartlang/dart-repl-poc-f327e3769b6f)
* publish package
* show to the community
* write readme