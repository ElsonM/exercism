//
// This is only a SKELETON file for the 'Line Up' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const format = (name, number) => {
  let suffix = 'th';

  if (number % 100 < 11 || number % 100 > 13) {
    if (number % 10 === 1) {
      suffix = 'st';
    } else if (number % 10 === 2) {
      suffix = 'nd';
    } else if (number % 10 === 3) {
      suffix = 'rd';
    }
  }

  return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`;
};
