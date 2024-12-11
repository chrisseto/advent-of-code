(def input (slurp "input.txt"))
(def example "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")

(defn mul-to-op [a b] ~(acc (* ,a ,b)))

(def op-peg
  ~{:mul (cmt (* "mul(" (number :d+) "," (number :d+) ")") ,mul-to-op)
    :do (* "do()" (constant (run-do)))
    :dont (* "don't()" (constant (run-dont)))
    :main (any (choice :mul :dont :do 1))})

# Buckle up buckaroo, our peg turns the corrupted input into...
# a valid janet program.
(defn parse-aoc [input allow-toggle]
  ~(do
     (var sum 0)
     (var enabled true)
     (defn acc [x]
       (if enabled (+= sum x)))
     (defn run-do [] (set enabled true))
     (defn run-dont [] (set enabled ,(not allow-toggle)))
     ,;(peg/match op-peg input)
     (printf "sum: %d" sum)))

# Part 1: No dos or don'ts
(eval (parse-aoc input false))

# Part 2: dos and don'ts
(eval (parse-aoc input true))
