# == Schema Information
#
# Table name: panda_app_versions
#
#  id                  :integer          not null, primary key
#  current_version     :string
#  latest_download_url :string
#  minimal_version     :string
#  pre_version         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  app_id              :integer          not null
#
# Indexes
#
#  index_panda_app_versions_on_app_id  (app_id)
#
# Foreign Keys
#
#  app_id  (app_id => panda_apps.id)
#
module Panda
  class AppVersion < ApplicationRecord
    belongs_to :app
  end
end
