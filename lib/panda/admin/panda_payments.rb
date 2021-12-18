ActiveAdmin.register Panda::Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :target_type, :target_id, :payment_method_type, :payment_method_id, :comment, :payee_type, :payee_id, :payer_type, :payer_id, :amount_in_cent, :fee_in_cent, :actual_pay_in_cent, :channel, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:target_type, :target_id, :payment_method_type, :payment_method_id, :comment, :payee_type, :payee_id, :payer_type, :payer_id, :amount_in_cent, :fee_in_cent, :actual_pay_in_cent, :channel, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
