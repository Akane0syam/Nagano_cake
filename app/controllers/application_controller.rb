class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    public_customer_path(@customer.id) # ログイン後に遷移するpathを設定
  end
  
  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number])
  end
end
