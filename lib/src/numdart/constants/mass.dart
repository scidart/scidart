import 'physical.dart';

// mass in kg
// Reference: https://physics.nist.gov/cuu/Constants/
// Reference: https://github.com/scipy/scipy/blob/master/scipy/constants/constants.py

const gram = 1e-3;
const metricTon = 1e3;
const grain = 64.79891e-6;

const lb = 7000 * grain; // avoirdupois
const pound = lb;

const blob = pound * g / 0.0254; // lbf*s**2/in (added in 1.0.0)
const slinch = blob;

const slug = blob / 12; // lbf*s**2/foot (added in 1.0.0)

const oz = pound / 16;
const ounce = oz;

const stone = 14 * pound;
const longTon = 2240 * pound;
const shortTon = 2000 * pound;

const troyOunce = 480 * grain; // only for metals / gems
const troyPound = 12 * troyOunce;
const carat = 200e-6;

/// electron mass
const mE = 9.1093837015e-31;
const electronMass = mE;

/// proton mass
const mP = 1.67262192369e-27;
const protonMass = mP;

/// neutron mass
const mN = 1.67492749804e-27;
const neutronMass = mN;

/// atomic mass constant
const mU = 1.66053906660e-27;
const u = mU;
const atomicMass = u;
