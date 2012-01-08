(ns conway.test.core
  (:require clojure.contrib.combinatorics)
  (:use [conway.core])
  (:use [clojure.test]))

(def square #{[2 1] [2 2] [1 1] [1 2]})

(defn evolve [live_cells] live_cells)

(defn neighbors [[cell-x cell-y]]
  (map (fn [[x y]] [(+ cell-x x) (+ cell-y y)])
       [[-1 -1] [-1 0] [-1 1]
        [0 -1] [0 1]
        [1 -1] [1 0] [1 1]]))



(deftest empty-board-is-stable
  (is #{} ( evolve #{})))

(deftest square-board-is-stable
  (is square (evolve square)))

(deftest lonely-board-dies
  (is #{} (evolve #{[1 1]})))
