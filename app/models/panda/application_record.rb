module Panda
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    include QueryAble
    include ParamAble
    # resourcify for rolify
    # resourcify
  end
end
