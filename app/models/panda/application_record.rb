module Panda
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    include QueryAble
    # resourcify for rolify
    # resourcify
  end
end
