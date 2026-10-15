## 0.1.1

Fixes:
- `randomArray2d(rows, columns)` returns `rows` rows of `columns` values; it had rows and columns swapped
- `fft` with `n` larger than the input appends the zeros at the end, like `numpy.fft.fft`; they were added at the start, which changed the phase of the result. `rfft` gets the same fix
- `toString` of `Array` and `Complex` no longer starts with a line break, as their documentation shows. `ArrayComplex` prints on one line, and `Array2d` and `Array3d` print one row per line without trailing spaces

Docs:
- API documentation builds without warnings (unresolved references in doc comments)
- The scidart.org site is rebuilt after each release

## 0.1.0

New:
- `NormalDistribution` in `stats`: `pdf`, `logPdf`, `cdf`, `sf`, `ppf`, `isf`, `interval`, `sample` and Array versions, like `scipy.stats.norm` (#44)
- `erf`, `erfc`, `arrayErf` and `arrayErfc` in `special`
- `rootScalar` in `optimize` with the `bisect`, `brentq`, `newton` and `secant` methods, like `scipy.optimize.root_scalar` (#56)
- `root` in `optimize` for systems of equations with the `lm` (Levenberg-Marquardt), `newton` and `broyden1` methods, returning an `OptimizeResult`, like `scipy.optimize.root` (#56)
- `PolyFitMultivariate`: polynomial regression with several features and outputs, with interaction terms in the order of `sklearn.preprocessing.PolynomialFeatures`; uses the minimum norm solution when there are more terms than samples (#55)

## 0.0.3

Breaking changes:
- `rifft` follows `numpy.fft.irfft`: the output length is `2 * (x.length - 1)` by default and the new `n` argument sets it. Pass `n` with the original length to recover signals of odd length (#47)
- `rifft` returns the real part of the inverse FFT instead of the absolute value (#47)
- `==` of `Array`, `Array2d`, `ArrayComplex` and `Complex` returns `false` for other types and lengths instead of throwing, and `hashCode` is consistent with `==`
- The minimum Dart SDK is 3.0.0

Fixes:
- `PolyFit` no longer loops forever with `Infinity` or `NaN` values, it throws `FormatException` (#65)
- `PolyFit` reduces the degree correctly when there are not enough distinct `x` values and scales the Vandermonde matrix like numpy with an overflow-safe norm, fixing wrong fits and negative R² (#37, #58). A degree larger than `x.length - 1`, or one whose powers of `x` overflow, is reduced
- `QR` uses the stable Householder sign again and matches the numpy signs; `QR.isFullRank` accepts a `tolerance`
- `SVD` throws `FormatException` for non-finite values instead of looping forever
- `median` no longer sorts the caller's array (#59)
- `firwin` accepts `pass_zero` as `'lowpass'`, `'highpass'`, `'bandpass'` and `'bandstop'` (#63 by j4ger)
- `simpsArray` with an even number of samples and no `x` uses `dx` instead of failing
- `truncate` works with values larger than 2^63

New:
- `multimode` returns all the most frequent values (#62)

Maintenance:
- Lints from `package:lints` replace the discontinued `pedantic`
- CI runs on Linux, macOS, Windows and Chrome, with the minimum and the stable SDK
- Publishing to pub.dev uses automated publishing (OIDC) when a `v*` tag is pushed

## 0.0.2-dev.13

- Sort array before median calculation (#59 Closed)

## 0.0.2-dev.12

- Add operation created for Array2d (#48 Closed)

## 0.0.2-dev.11

- Enhance complex concat (#49 Closed)

## 0.0.2-dev.10

- PR #46 by myConsciousness merged (unnecessary imports removed and YML update)

## 0.0.2-dev.9

- `arange` moved to deprecated and replaced by `createArrayRange`, #39 closed
- some typos fixed

## 0.0.2-dev.8
- Issue Infinite loop, memory exhausted with PolyFit(x, y, degree) #37, solved
- some typos fixed

## 0.0.2-dev.7
- Typos in the Source Code

## 0.0.2-dev.6
- Performance improvements for Array.add

## 0.0.2-dev.5
- Array2d.fromArray is not deep copying the arrays in the list of arrays #31
- subArray2d and getColumn new methods 

## 0.0.2-dev.4
- singular value decomposition for matrix m != n (SVD)
- SVD bug to get U, V and S matrix fixed
- pseudo inverse matrix using Moore–Penrose (matrixPseudoInverse)
- new tests cases with matrix m != n
- new tests cases for SVD with matrix m != n
- matrixSub limit index added to avoid break
- array2dInverseOfEachElement bug for elements equal 0 fixed, just keep it 0

## 0.0.2-dev.3
- new array2d operations: array2dInverseOfEachElement, array2dPow

## 0.0.2-dev.2
- new array2d operations created: array2dAddToScalar, array2dDivisionToScalar, array2dMultiplyToScalar, array2dSubToScalar
- new array operation created: arrayAddToScalar
- new tests created for array and array2d operations

## 0.0.2-dev.1
- Null safety added to the package
- FFT bug to big power of 2 arrays fixed
- complexExp function created to calculate complex number natural exponent
- arrayConcat changed to concatenate N arrays

## 0.0.1-dev.12
- PR #22 merged: Remove unused dart: imports

## 0.0.1-dev.11

- Even and Odd number double check created;
- cross correlation for real and complex signals created;
- dartfmt applied in the code;

## 0.0.1-dev.10

- Even and Odd number int check created;
- matrix transpose bug fixed;
- classes documentations improved;

## 0.0.1-dev.9

- PolyFit issue #16;
- Dart lint warning fixed;

## 0.0.1-dev.8

- Logo url update.

## 0.0.1-dev.7

- License changed and documentation updates.

## 0.0.1-dev.6

- bug correction issue: https://github.com/scidart/scidart/issues/7 .

## 0.0.1-dev.5

- pubspec homepage updated.

## 0.0.1-dev.4

- README examples updated.

## 0.0.1-dev.3

- IO migrated to scidart_io.

## 0.0.1-dev.2

- Readme file updated.

## 0.0.1-dev.1

- NumDart, SciDart and IO fundamentals implemented and documented.
