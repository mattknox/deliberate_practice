# A friend asked if I could think of an easy heuristic to do search on a chat stream.
# The first good heouristic I found was to look for runs of capitalized words.  Here's a function for that.

def longest_runs_of_capitals(s)
  longest_run, current_run = [], []
  a = s.split
  a.first.downcase!
  a.each_with_index do |x, i|
    x.downcase! if x == "I"
    if x.match /^[A-Z]/
      current_run << x
      longest_run = current_run.clone if current_run.size >= longest_run.size # last in wins ties
    else
      current_run = []
    end
    current_run = [] if x.match /[?!.,]$/ # puctuation should end a run.
    a[i + 1].downcase! if  a[i + 1] && x.match(/[?!.]$/) # End of sentence should end a run.
  end
  longest_run if longest_run.size > 0
end


# Interestingly, there are three kinds of classification here: does the element of the sequence satisfy the
# condition for being in a run, does it stop the run, and does it disqualify the next token from being in a run.
