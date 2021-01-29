import 'length.dart';

/// volume in meter**3

const litre = 1e-3;
const liter = litre;

const gallon = 231 * inch * inch * inch; // US
const gallonUS = gallon;

/// pint = gallon_US / 8
const fluidOunce = gallonUS / 128;
const fluidOunceUS = fluidOunce;

/// for oil
const bbl = 42 * gallonUS;
const barrel = bbl;

/// UK
const gallonImp = 4.54609e-3;
const fluid_ounce_imp = gallonImp / 160;
