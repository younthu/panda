# == Schema Information
#
# Table name: panda_payments
#
#  id                  :integer          not null, primary key
#  actual_pay_in_cent  :integer
#  amount_in_cent      :integer
#  channel             :string
#  comment             :string
#  fee_in_cent         :integer
#  payee_type          :string
#  payer_type          :string
#  payment_method_type :string           not null
#  status              :string
#  target_type         :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  payee_id            :integer
#  payer_id            :integer
#  payment_method_id   :integer          not null
#  target_id           :integer
#
# Indexes
#
#  index_panda_payments_on_payee           (payee_type,payee_id)
#  index_panda_payments_on_payer           (payer_type,payer_id)
#  index_panda_payments_on_payment_method  (payment_method_type,payment_method_id)
#  index_panda_payments_on_target          (target_type,target_id)
#
require "test_helper"

module Panda
  class PaymentTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
