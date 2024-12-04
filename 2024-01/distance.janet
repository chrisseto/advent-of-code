(defn slurp-lines [path]
  (string/split "\n" (slurp path)))

(def lines
  (-> "input.txt"
   (slurp-lines)
   (array/remove -1))) # Remove trailing newline

(def [lhs rhs] [@[] @[]])

(each line lines
  (def [lhv rhv]
   (->> line
    (string/split " ")
    (filter (fn [x] (not (empty? x))))
    (map scan-number)))
  (array/push lhs lhv)
  (array/push rhs rhv))

(sort lhs)
(sort rhs)

(var distance 0)
(for i 0 (length lhs)
  (+= distance
    (math/abs
      (-
       (get lhs i)
       (get rhs i)))))

(printf "distance: %d" distance)
