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
* IO: File manipulation libraries;
  * csv: [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file manipulation;
  * txt: text file manipulation;
* NumDart: Numerical computation libraries;
  * array_base: array manipulation;
  * calculus: calculus base;
  * constants: scientific constants;
  * fastmath: optimized math operations;
  * geometric: geometric related operations;
  * interpolation: discrete function interpolation;
  * linalg: linear algebra algorithms: matrix, decomposition, etc;
  * numbers: numeric base that are missing in Dart by default: Complex, double truncation, etc;
  * polynomial: polynomial estimation, regression, etc;
  * random: random data generation;
  * spaces: vector linear spaces generators: arrange, ones, linspace, etc;
  * statistic: statistic computation;
  * time: execution time measurement;
* SciDart: Scientific computation libraries;
  * fftpack: fourier transformer tools;
    * dbfft
    * fft
    * fftfreq
    * rfft
  * signal: signal manipulation tools;
    * convolution
    * fir
    * lfilter
    * windows
  * special: special functions;
    * bessel

## Examples
### NumDart basics
#### Arrays
```Dart
```

#### Numeric spaces

#### Random data generation

#### Array operations

#### Matrix operations

#### Complex operations

#### Calculus operations

#### Interpolation

#### Polynomial

#### Statistic

#### Time

### SciDart basics
#### fftpack
#### signal
#### special

### Complete examples
#### Avoid spectral leakage


#### Step counter


#### Frequency estimator
```Dart
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

void main() {
  // generate the signals for test
  // 1Hz sine wave
  var N = 50.0;
  var fs = 128.0;
  var n = linspace(0, N, num: (N * fs).toInt(), endpoint: false);
  var f1 = 1.0; // 1Hz
  var sg1 = arraySin(arrayMultiplyToScalar(n, 2 * pi * f1));

  var fEstimated = freqFromFft(sg1, fs);

  print('The original and estimated frequency need be very close each other');
  print('Original frequency: ${f1}');
  print('Estimated frequency: ${fEstimated}');
}

double freqFromFft(Array sig, double fs) {
  // Estimate frequency from peak of FFT

  // Compute Fourier transform of windowed signal
  // Avoid spectral leakage: https://en.wikipedia.org/wiki/Spectral_leakage
  var windowed = sig * blackmanharris(sig.length);
  var f = rfft(windowed);

  var fAbs = arrayComplexAbs(f);

  // Find the peak and interpolate to get a more accurate peak
  var i = arrayArgMax(fAbs); // Just use this for less-accurate, naive version

  // Parabolic approximation is necessary to get the exactly frequency of a discrete signal
  // since the frequency can be in some point between the samples.
  var true_i = parabolic(arrayLog(fAbs), i)[0];

  // Convert to equivalent frequency
  return fs * true_i / windowed.length;
}
```

## Inspiration
Below, the list of the main references of **SciDart**:

* SciPy: https://www.scipy.org/
* Jupyter: https://jupyter.org/
* JAMA A Java Matrix Package: https://math.nist.gov/javanumerics/jama/
* Commons Math The Apache Commons Mathematics Library: https://commons.apache.org/proper/commons-math/
* Roseta code: https://rosettacode.org/

## How to contribute
I recommend see the Todo List and choose a function to implement or choose and solve a problem with **SciDart** and 
implement the missing parts.

The references values for all function was obtained with SciPy. The contributions need use SciPy as reference too.

Every contribution needs have tests, documentation and examples, otherwise, the pull request will be blocked.

## Todo list
### Project documentation
* create a logo
* create a official web site
* adjust the documentation to be more friendly for the users
* write tutorials

### Benchmarks
* construct codes for benchmark tests
* made benchmark for Android devices
* made benchmark for iOS devices
* made benchmark on Web
* made benchmark on Linux
* made benchmark on MacOS
* made benchmark on MS Windows

### Code implementations
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