(ns conway.core)

(defn- neighbors [[cell-x cell-y]]
  (map (fn [[x y]] [(+ cell-x x) (+ cell-y y)])
       [[-1 -1] [-1 0] [-1 1]
        [0 -1]         [0 1]
        [1 -1]  [1 0]  [1 1]]))

(defn- count-neighbors [live-cells]
  (reduce (fn [x y] (conj x [y (inc (or (x y) 0))]))
                                {}
                                (reduce into
                                        '()
                                        (map (fn [x] (neighbors x))
                                             live-cells))))

(defn- live? [cell live-neighbor-count live-cells]
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

