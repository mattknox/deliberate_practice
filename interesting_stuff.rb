def load_all
  # in rails, load all the ruby files in a directory (useful in dev)
  `ls #{Rails.root}/app/models`.split.grep(/rb$/).map {|s| require s }
end


def count_all_tables
  # count every table.  Useful when determining whether a setup script
  # that inserts rows is idempotent
  ActiveRecord::Base.subclasses.sort_by(&:name).map &:count
end
