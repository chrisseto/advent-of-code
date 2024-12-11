(def input-txt (string/trimr (slurp "input.txt")))

(defn all? [arr]
  (reduce2
    (fn [acc el] (and acc el))
    arr))

(defn seq-pairs [f arr]
  (seq [i :range [0 (- (length arr) 1)]]
    (def a (get arr i))
    (def b (get arr (+ i 1)))
    (f a b)))

(defn is-increasing? [arr]
   (->> arr
     (seq-pairs <)
     all?))

(defn is-decreasing? [arr]
   (->> arr
     (seq-pairs >)
     all?))

(defn delta-within? [lower upper arr]
 (defn within-range? [a b] 
  (def x (math/abs (- a b)))
  (and (>= x lower) (<= x upper)))
 (->> arr
   (seq-pairs within-range?)
   (all?)))

(is-increasing? @[1 2 3])
(is-increasing? @[1 2 4])
(is-increasing? @[1 2 1 1])
(delta-within? -1 2 @[1 2 1 1])

(defn is-safe? [report]
 (and
   (delta-within? 1 3 report)
   (or
     (is-increasing? report)
     (is-decreasing? report))))

(defn is-safe-with-dampener? [report]
  (var perms @[report])
  (for i 0 (length report)
    (def clone (map identity report))
   (array/push perms (array/remove clone i)))
  (any? (map is-safe? perms)))

(var safe 0)
(var safe-with-dampener 0)
(loop [line :in (string/split "\n" input-txt)]
  (def report
    (map
      scan-number
      (string/split " " line)))
  (if (is-safe? report) (++ safe))
  (if (is-safe-with-dampener? report) (++ safe-with-dampener)))

(printf "# safe (part 1): %d" safe)
(printf "# safe with dampener (part 2): %d" safe-with-dampener)
