//
// This is only a SKELETON file for the 'Raindrops' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
export const convert = number => (number % 3 === 0 ? 'Pling' : '') +
                                 (number % 5 === 0 ? 'Plang' : '') +
                                 (number % 7 === 0 ? 'Plong' : '') || String(number);