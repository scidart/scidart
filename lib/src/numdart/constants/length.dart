import 'math.dart';
import 'physical.dart';
import 'time.dart';

// length in meter
const inch = 0.0254;
const foot = 12 * inch;
const yard = 3 * foot;
const mile = 1760 * yard;
const mil = inch / 1000;
const pt = inch / 72; // typography
const point = pt;

const surveyFoot = 1200.0 / 3937;

const surveyMile = 5280 * surveyFoot;
const nauticalMile = 1852.0;
const fermi = 1e-15;
const angstrom = 1e-10;
const micron = 1e-6;

const au = 149597870700.0;
const astronomicalUnit = au;

const lightYear = JulianYear * c;
const parsec = au / arcsec;
