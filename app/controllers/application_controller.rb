class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  
  def after_sign_in_path_for(resource_or_scope)#ログイン後に遷移するpathを設定
    if resource_or_scope.is_a?(Admin)
      admin_orders_path
    else
      root_path
    end
  end
  
  
  def move_to_signed_in
    unless customer_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to new_customer_session_path
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number])
  end
end
