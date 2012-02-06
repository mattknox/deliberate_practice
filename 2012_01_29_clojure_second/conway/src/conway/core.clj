(ns conway.core
  (:use clojure.contrib.combinatorics))

(defn- neighbors [[cell-x cell-y]]
  (map (fn [[x y]] [(+ cell-x x) (+ cell-y y)])
       [[-1 -1] [-1 0] [-1 1]
        [0 -1]         [0 1]
        [1 -1]  [1 0]  [1 1]]))

(defn- count-neighbors [live-cells]
  (group-by identity (reduce into '()
                             (map neighbors live-cells))))

(defn- live? [count is-live?]
  (or (= 3 count)
      (and is-live? (= 2 count))))

(defn evolve [live-cells]
  (let [neighbor-counts (count-neighbors live-cells)]
    (set (filter (fn [c] (live? (count (neighbor-counts c)) (live-cells c)))
                 (keys neighbor-counts)))))
