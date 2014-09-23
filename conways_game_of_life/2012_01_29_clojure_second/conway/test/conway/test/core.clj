(ns conway.test.core
  (:use [conway.core])
  (:use [clojure.test]))

(def square-board #{[2 1] [2 2] [1 1] [1 2]})

(deftest empty-board-is-stable
  (is (= #{} (evolve #{}))))

(deftest square-board-is-stable
  (is (= square-board (evolve square-board))))

(deftest lonely-board-dies
  (is (= #{} (evolve #{[1 1]}))))
