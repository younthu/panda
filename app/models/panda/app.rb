# == Schema Information
#
# Table name: panda_apps
#
#  id             :integer          not null, primary key
#  name           :string
#  official_site  :string
#  owner_name     :string
#  platform       :string
#  published_at   :date
#  support_email  :string
#  support_name   :string
#  support_phone  :string
#  support_wechat :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
module Panda
  class App < ApplicationRecord
  end
end
