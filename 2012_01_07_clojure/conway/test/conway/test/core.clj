(ns conway.test.core
  (:require clojure.contrib.combinatorics)
  (:use [conway.core])
  (:use [clojure.test]))

(def square #{[2 1] [2 2] [1 1] [1 2]})

(defn neighbors [[cell-x cell-y]]
  (map (fn [[x y]] [(+ cell-x x) (+ cell-y y)])
       [[-1 -1] [-1 0] [-1 1]
        [0 -1] [0 1]
        [1 -1] [1 0] [1 1]]))

(defn evolve [live-cells]
  (let [neighbor-counts (reduce (fn [x y] (conj x [y (inc (or (x y) 0))]))
                                {}
                                (reduce into
                                        '()
                                        (map (fn [x] (neighbors x))
                                             live-cells)))]
    (set (filter (fn [c] (or (= 3 (neighbor-counts c))
                            (and (= 2 (neighbor-counts c)) (live-cells c))))
                 (keys (reduce (fn [x y] (conj x [y (inc (or (x y) 0))]))
                               {}
                               (reduce into
                                       #{}
                                       (map (fn [x] (neighbors x))
                                            live-cells))))))))

(deftest empty-board-is-stable
  (is (= #{} (evolve #{}))))

(deftest square-board-is-stable
  (is (= square (evolve square))))

(deftest lonely-board-dies
  (is (= #{} (evolve #{[1 1]}))))
