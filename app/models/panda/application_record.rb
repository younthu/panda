module Panda
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true

    include QueryAble
    include ParamAble
    # resourcify for rolify
    # resourcify
  end
end
