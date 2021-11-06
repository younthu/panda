# == Schema Information
#
# Table name: panda_identities
#
#  id            :integer          not null, primary key
#  expires_at    :integer
#  provider      :string
#  refresh_token :string
#  scopes        :string
#  status        :string
#  token         :string
#  uid           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_panda_identities_on_provider       (provider)
#  index_panda_identities_on_refresh_token  (refresh_token)
#  index_panda_identities_on_status         (status)
#  index_panda_identities_on_token          (token)
#  index_panda_identities_on_uid            (uid)
#  index_panda_identities_on_user_id        (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
module Panda
  class Identity < ApplicationRecord
    belongs_to :user
  end
end
