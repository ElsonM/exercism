//
// This is only a SKELETON file for the 'Anagram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const findAnagrams = (target, candidates) => {
  const normalizedTarget = target.toLowerCase();
  const sortedTarget = [...normalizedTarget].sort().join('');

  return candidates.filter(candidate => {
    const normalizedCandidate = candidate.toLowerCase();
    const sortedCandidate = [...normalizedCandidate].sort().join('');

    return normalizedCandidate !== normalizedTarget && 
           sortedCandidate === sortedTarget; 
  });
};
