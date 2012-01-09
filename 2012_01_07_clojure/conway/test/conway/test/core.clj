(ns conway.test.core
  (:use [conway.core])
  (:use [clojure.test]))

(defn neighbors [[cell-x cell-y]]
  (map (fn [[x y]] [(+ cell-x x) (+ cell-y y)])
       [[-1 -1] [-1 0] [-1 1]
        [0 -1]         [0 1]
        [1 -1]  [1 0]  [1 1]]))

(defn count-neighbors [live-cells]
  (reduce (fn [x y] (conj x [y (inc (or (x y) 0))]))
                                {}
                                (reduce into
                                        '()
                                        (map (fn [x] (neighbors x))
                                             live-cells))))

(defn live? [cell live-neighbor-count live-cells]
  (or (= 3 live-neighbor-count)
      (and (= 2 live-neighbor-count) (live-cells cell))))

(defn evolve [live-cells]
  (let [neighbor-counts (count-neighbors live-cells)]
    (set (filter (fn [c] (live? c (neighbor-counts c) live-cells))
                 (keys (reduce (fn [x y] (conj x [y (inc (or (x y) 0))]))
                               {}
                               (reduce into
                                       #{}
                                       (map (fn [x] (neighbors x))
                                            live-cells))))))))

(def square #{[2 1] [2 2] [1 1] [1 2]})

(deftest empty-board-is-stable
  (is (= #{} (evolve #{}))))

(deftest square-board-is-stable
  (is (= square (evolve square))))

(deftest lonely-board-dies
  (is (= #{} (evolve #{[1 1]}))))
