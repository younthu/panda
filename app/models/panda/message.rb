module Panda
  class Message < ApplicationRecord
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true
    belongs_to :payload, polymorphic: true
  end
end
