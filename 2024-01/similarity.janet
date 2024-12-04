(def list-peg ~(some (* (number :d+) "   " (number :d+) "\n")))

# This time with PEGs
(def input
  (peg/match list-peg (slurp "input.txt")))

# Count frequencies of the RH list by iterating over all odd indexes.
(def rhs-freq @{})
(loop [i :range [0 (length input)] :when (odd? i)]
  (def num (get input i))
  (set (rhs-freq num) (inc (get rhs-freq num 0))))

# Calculate similarity by multiplying num by it's frequency in the RH list.
(var similarity 0)
(loop [i :range [0 (length input)] :when (even? i)]
 (def num (get input i))
 (+= similarity (* num (get rhs-freq num 0))))

(printf "similarity: %d" similarity)
