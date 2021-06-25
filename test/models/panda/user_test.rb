require "test_helper"

module Panda
  class UserTest < ActiveSupport::TestCase
    setup do

    end
    test "required fields for user" do
      u1 = panda_users(:one)
      assert u1.present?
    end
  end
end
