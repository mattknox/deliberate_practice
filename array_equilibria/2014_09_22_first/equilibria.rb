class Array
  def to_running_sum
    sum = 0
    out = Array.new(length, 0)
    (0...self.length).each do |i|
      sum += self[i]
      out[i] = sum
    end
    out
  end

  def sum
    inject(0) { |m, x| m + x }
  end
end

def make_eq_arrs(aa)
  xs = Array.new(aa.first.size, 0)
  ys = Array.new(aa.size, 0)

  aa.each_with_index do |arr, y|
    arr.each_with_index do |val, x|
      xs[x] += val
      ys[y] += val
    end
  end
  return xs, ys
end

def find_pivots(arr)
  # return a potentially empty list of indices of pivot points in an array arr
  # pivot points have the same sum on either side.
  (0...arr.size).to_a.select { |i| arr[0...i].sum == arr[(i + 1)..-1].sum }
end


def find_2d_pivots(aa)
  # make 2 vectors of running sums
  xs, ys = make_eq_arrs(aa)
  find_pivots(xs).product find_pivots(ys)
end


find_2d_pivots([[1,0,0,0,1],[1,0,0,0,1],[1,0,0,0,1]])
