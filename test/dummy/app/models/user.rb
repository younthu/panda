class User < ApplicationRecord
  self.table_name = "panda_users"
  include PandaUser
end
