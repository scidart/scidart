import 'length.dart';

// volume in meter**3

const litre = 1e-3;
const liter = litre;

const gallon = 231 * inch * inch * inch; // US
const gallonUS = gallon;

// pint = gallon_US / 8
const fluidOunce = gallonUS / 128;
const fluidOunceUS = fluidOunce;

const bbl = 42 * gallonUS; // for oil
const barrel = bbl;

const gallonImp = 4.54609e-3; // UK
const fluid_ounce_imp = gallonImp / 160;
