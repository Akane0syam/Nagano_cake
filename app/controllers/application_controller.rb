class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters , if: :devise_controller?
  
  
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
