ActiveAdmin.register Panda::Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :comment, :business_type, :status, :owner_type, :owner_id, :title, :code, :price_in_cent
  #
  # or
  #
  # permit_params do
  #   permitted = [:comment, :business_type, :status, :owner_type, :owner_id, :title, :code, :price_in_cent]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
